//
//  CategoryGamesList.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 22.12.2023.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CategoryGamesList {
    struct State: Equatable, Identifiable {
        var id: UUID
        private var category: CategoryData
        var tabIndex: Int { category.type.tabIndex }
        var categoryName: String { category.name }
        var games: [GameData]

        init(category: CategoryData) {
            @Dependency(\.uuid) var uuid
            @Dependency(\.appData.get) var appData
            self.id = uuid.callAsFunction()
            self.category = category
            self.games = appData().gamesData(for: category)
        }
    }

    enum Action: Equatable {
        case didSelectGame(GameType)
    }

    var body: some Reducer<State, Action> {
        Reduce { _, _ in
            return .none
        }
    }
}
