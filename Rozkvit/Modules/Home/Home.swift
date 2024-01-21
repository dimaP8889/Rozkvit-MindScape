//
//  Home.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Home {
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

// MARK: - State
extension Home {
    struct State: Equatable {
        
    }
}

// MARK: - Action
extension Home {
    enum Action: Equatable {

    }
}

