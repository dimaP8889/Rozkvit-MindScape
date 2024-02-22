//
//  Games.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Games {
    @Reducer
    struct Destination {
        enum State: Equatable {
            case selectedGame(GameEvent.State)
        }

        enum Action: Equatable {
            case selectedGame(GameEvent.Action)
        }

        var body: some Reducer<State, Action> {
            Scope(state: \.selectedGame, action: \.selectedGame) {
                GameEvent()
            }
        }
    }

    struct State: Equatable {
        var selectedCategoryIndex: Int
        var categories: IdentifiedArrayOf<CategoryGamesList.State> = []
        @PresentationState var destination: Destination.State?

        init() {
            @Dependency(\.appData) var appData
            self.categories = appData.categoriesData
            self.selectedCategoryIndex = 0
        }
    }

    enum Action: Equatable {
        case didSelectCategoryIndex(Int)
        case didUpdateData(AppData)
        case task
        case categories(IdentifiedActionOf<CategoryGamesList>)
        case destination(PresentationAction<Destination.Action>)
    }

    @Dependency(\.appData) var appData

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectCategoryIndex(index):
                state.selectedCategoryIndex = index
                return .none

            case let .didUpdateData(appData):
                state.categories = appData.categoriesData
                return .none

            case .task:
                return .run { send in
                    for await appData in self.appData.stream() {
                        await send(.didUpdateData(appData))
                    }
                }

            case let .categories(.element(_, .didSelectGame(type))):
                let game = createGame(with: type)
                state.destination = .selectedGame(GameEvent.State(game: game))
                return .none

            case let .destination(.presented(.selectedGame(.delegate(.didSubmit(game, result))))):
                guard case .selectedGame = state.destination 
                else { return .none }

                submitGameResult(game: game, result: Int(result))
                state.destination = nil
                return .none

            case .destination(.presented(.selectedGame)):
                return .none

            case .destination(.dismiss):
                state.destination = nil
                return .none
            }
        }
        .forEach(\.categories, action: \.categories) {
            CategoryGamesList()
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
}

// MARK: - Middlewares
extension Games {
    func createGame(with type: GameType) -> GameEnvironment {
        let builder = GameBuilder()
        return builder.createGame(for: type)
    }

    func submitGameResult(game: GameType, result: Int) {
        Task {
            await appData.setGameStatistic(game, result)
        }
    }
}
