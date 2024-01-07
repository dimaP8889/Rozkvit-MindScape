//
//  GameEvent.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 06.01.2024.
//

import ComposableArchitecture

@Reducer
struct GameEvent {
    struct State: Equatable {
        struct Core: Equatable {
            var game: GameEnvironment
            var currentSlide: GameSlide? {
                didSet { 
                    currentSelectedAnswer = nil
                    if currentSlide == nil {
                        isFinished = true
                    }
                }
            }
            var isFinished: Bool

            var currentSelectedAnswer: GameAnswer?

            init(game: GameEnvironment) {
                self.game = game
                self.currentSlide = game.nextSlide()
                self.currentSelectedAnswer = nil
                self.isFinished = false
            }
        }

        struct UI: Equatable {
            private var game: GameEnvironment
            var resultString: String {
                "\(String(format: "%.0f", game.percentOfCorrectAnswers() * 100))%"
            }

            var currentPage: Int
            var currentPageText: String {
                return "\(currentPage)/\(game.amountOfSlides)"
            }

            init(game: GameEnvironment) {
                self.game = game
                self.currentPage = 1
            }
        }

        var core: Core
        var ui: UI

        init(game: GameEnvironment) {
            self.core = Core(game: game)
            self.ui = UI(game: game)
        }
    }

    enum Action: Equatable {
        case didSelectAnswer(GameAnswer)
        case didPressContinue
        case didPressFinish
        case didPressClose
        case delegate(Delegate)

        enum Delegate: Equatable {
            case didSubmit(game: GameType, result: Double)
        }
    }

    @Dependency(\.dismiss) var dismiss

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectAnswer(answer):
                state.core.currentSelectedAnswer = answer
                return .none

            case .didPressContinue:
                guard let answer = state.core.currentSelectedAnswer else {
                    return .none
                }
                state.core.game.submit(result: answer.isCorrect)
                state.core.currentSlide = state.core.game.nextSlide()
                state.ui.currentPage += 1
                return .none

            case .didPressFinish:
                let gameType = state.core.game.type
                let result = state.core.game.percentOfCorrectAnswers()
                return .send(.delegate(.didSubmit(game: gameType, result: result)))

            case .didPressClose:
                return .run { _ in await self.dismiss() }

            case .delegate:
                return .none
            }
        }
    }
}
