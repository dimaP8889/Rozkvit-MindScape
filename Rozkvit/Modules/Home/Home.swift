//
//  Home.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct Home {
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
        var treeImage: Image
        var motivationText: String
        @PresentationState var destination: Destination.State?

        init() {
            @Dependency(\.appData.get) var appData
            self.treeImage = appData().homeTabData.treeImage
            self.motivationText = appData().homeTabData.motivationText
        }
    }

    enum Action: Equatable {
        case onInit
        case didUpdateData
        case didPressStart
        case destination(PresentationAction<Destination.Action>)
    }

    @Dependency(\.appData) var appData
    @Dependency(\.database) var database

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onInit:
                return .run { send in
                    for await _ in self.appData.stream() {
                        await send(.didUpdateData)
                    }
                }

            case .didUpdateData:
                state.treeImage = appData.homeTabData.treeImage
                state.motivationText = appData.homeTabData.motivationText
                return .none

            case .didPressStart:
                let game = appData.homeTabData.nextGame
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
        .ifLet(\.$destination, action: \.destination) {
            Destination()
        }
    }
}

extension Home {
    func submitGameResult(game: GameType, result: Int) {
        Task {
            let date = Int(Date().timeIntervalSince1970)
            let data = DatabaseGameStatistic(game: game, date: date, result: result)
            await appData.addGameStatistic(data)
            try await database.save(data)
        }
    }
}
