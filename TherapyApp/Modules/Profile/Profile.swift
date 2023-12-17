//
//  Profile.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Profile {
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

// MARK: - State
extension Profile {
    struct State: Equatable {

    }
}

// MARK: - Action
extension Profile {
    enum Action: Equatable {

    }
}

