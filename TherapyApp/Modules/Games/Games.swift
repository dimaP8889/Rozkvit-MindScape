//
//  Games.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Games {
    struct State: Equatable {
        var selectedItem: Int
        var categories: IdentifiedArrayOf<CategoryGamesList.State> = []

        init() {
            @Dependency(\.appData) var appData
            self.categories = appData.categoriesData
            self.selectedItem = 0
        }
    }

    enum Action: Equatable {
        case didSelectItem(Int)
        case categories(IdentifiedActionOf<CategoryGamesList>)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectItem(index):
                state.selectedItem = index
                return .none

            case .categories:
                return .none
            }
        }
        .forEach(\.categories, action: \.categories) {
            CategoryGamesList()
        }
    }
}
