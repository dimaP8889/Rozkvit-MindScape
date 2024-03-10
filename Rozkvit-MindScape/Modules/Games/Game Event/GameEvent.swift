//
//  GameEvent.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 06.01.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct GameEvent {
    struct State: Equatable {
        var currentPage = 1
        var game: GameEnvironment
        
        var result: String {
            "\(localStr("game.result.text")) \(game.percentOfCorrectAnswers())%"
        }
        var question: GameQuestion?
        var answers: GameEntityAnswerSection.State?
        var wrongAnswerDescription: GameEntityWrongAnswerDescription.State?
        var currentPageText: String {
            return "\(currentPage)/\(game.amountOfSlides)"
        }
        var isFinished: Bool
        var blur: CGFloat {
            wrongAnswerDescription == nil ? 0 : 20
        }

        init(game: GameEnvironment) {
            self.game = game
            
            if let slide = game.nextSlide() {
                answers = GameEntityAnswerSection.State(
                    answers: slide.answers,
                    currentSelectedAnswer: nil
                )

                question = slide.question
                wrongAnswerDescription = nil
                isFinished = false
            } else {
                isFinished = true
            }
        }
    }

    enum Action: Equatable {
        case answers(GameEntityAnswerSection.Action)
        case wrongAnswerDescription(GameEntityWrongAnswerDescription.Action)

        case showNextSlide
        case didPressContinue
        case didPressFinish
        case didPressClose

        case delegate(Delegate)

        enum Delegate: Equatable {
            case didSubmit(game: GameType, result: Int)
        }
    }

    @Dependency(\.dismiss) var dismiss

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .didPressContinue:
                guard let answer = state.answers?.currentSelectedAnswer else {
                    return .none
                }
                state.game.submit(result: answer.isCorrect)
                
                if !answer.isCorrect {
                    if let wrongAnswer = state.game.currentSlide?.wrongAnswerDescription {
                        state.wrongAnswerDescription = .init(model: wrongAnswer)
                    }
                    return .none
                }

                return .send(.showNextSlide)

            case .didPressFinish:
                let gameType = state.game.type
                let result = state.game.percentOfCorrectAnswers()
                return .send(.delegate(.didSubmit(game: gameType, result: result)))

            case .showNextSlide:
                state.currentPage += 1
                if let nextSlide = state.game.nextSlide() {
                    state.answers = GameEntityAnswerSection.State(
                        answers: nextSlide.answers,
                        currentSelectedAnswer: nil
                    )

                    state.question = nextSlide.question
                } else {
                    state.answers = nil
                    state.question = nil
                    state.isFinished = true
                }
                return .none

            case .wrongAnswerDescription(.didPressContinue):
                state.wrongAnswerDescription = nil
                return .send(.showNextSlide)

            case .didPressClose:
                return .run { _ in await self.dismiss() }

            case .answers:
                return .none

            case .delegate:
                return .none
            }
        }
        .ifLet(\.answers, action: \.answers) {
            GameEntityAnswerSection()
        }
        .ifLet(\.wrongAnswerDescription, action: \.wrongAnswerDescription) {
            GameEntityWrongAnswerDescription()
        }
    }
}
