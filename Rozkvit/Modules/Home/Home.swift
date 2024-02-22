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
    @Dependency(\.appData) var appData
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    for await appData in self.appData.stream() {
                        await send(.didUpdateData(appData))
                    }
                }

            case let .didUpdateData(data):
                let treeBuilder = TreeBuilder()
                state.treeImage = treeBuilder.tree(for: data.gameStatistic)
                return .none
            }
        }
    }
}

// MARK: - State
extension Home {
    struct State: Equatable {
        var treeImage: Image

        init() {
            @Dependency(\.appData.get) var appData
            let treeBuilder = TreeBuilder()
            self.treeImage = treeBuilder.tree(for: appData().gameStatistic)
        }
    }
}

// MARK: - Action
extension Home {
    enum Action: Equatable {
        case onAppear
        case didUpdateData(AppData)
    }
}

