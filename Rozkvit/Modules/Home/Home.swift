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
    struct State: Equatable {
        var treeImage: Image
        var motivationText: String

        init() {
            @Dependency(\.appData.get) var appData
            self.treeImage = appData().homeTabData.treeImage
            self.motivationText = appData().homeTabData.motivationText
        }
    }

    enum Action: Equatable {
        case onAppear
        case didUpdateData
    }

    @Dependency(\.appData) var appData
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    for await _ in self.appData.stream() {
                        await send(.didUpdateData)
                    }
                }

            case .didUpdateData:
                state.treeImage = appData.get().homeTabData.treeImage
                state.motivationText = appData.get().homeTabData.motivationText
                return .none
            }
        }
    }
}
