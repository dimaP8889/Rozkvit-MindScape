//
//  GameEntityWrongAnswerDescription.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import ComposableArchitecture

@Reducer
struct GameEntityWrongAnswerDescription {
    struct State: Equatable {
        var model: GameWrongAnswerDescription
    }

    enum Action: Equatable {
        case didPressContinue
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .didPressContinue:
                return .none
            }
        }
    }
}
