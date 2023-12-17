//
//  Games.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Games {
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

// MARK: - State
extension Games {
    struct State: Equatable {

    }
}

// MARK: - Action
extension Games {
    enum Action: Equatable {

    }
}

