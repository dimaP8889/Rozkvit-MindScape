//
//  Games.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import Foundation

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
            self.categories = appData.gamesTabData.categories
            self.selectedCategoryIndex = 0
        }
    }

    enum Action: Equatable {
        case didSelectCategoryIndex(Int)
        case didUpdateData
        case onFirstAppear
        case categories(IdentifiedActionOf<CategoryGamesList>)
        case destination(PresentationAction<Destination.Action>)
    }

    @Dependency(\.appData) var appData
    @Dependency(\.database) var database

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectCategoryIndex(index):
                state.selectedCategoryIndex = index
                return .none

            case .didUpdateData:
                state.categories = appData.gamesTabData.categories
                return .none

            case .onFirstAppear:
                return .run { send in
                    await withDiscardingTaskGroup { group in
                        group.addTask {
                            for await _ in self.appData.stream() {
                                await send(.didUpdateData)
                            }
                        }

                        group.addTask {
                            await send(.didUpdateData)
                        }
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
            let date = Int(Date().timeIntervalSince1970)
            let data = DatabaseGameStatistic(game: game, date: date, result: result)
            await appData.addGameStatistic(data)
            try await database.save(data)
        }
    }
}
