//
//  GameEntityAnswerSection.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 14.01.2024.
//

import ComposableArchitecture

@Reducer
struct GameEntityAnswerSection {
    struct State: Equatable {
        let answers: GameAnswers
        var currentSelectedAnswer: GameAnswerMetadata?
    }

    enum Action: Equatable {
        case didSelectAnswer(GameAnswerMetadata)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectAnswer(answer):
                state.currentSelectedAnswer = answer
                return .none
            }
        }
    }
}
