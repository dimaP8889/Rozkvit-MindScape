//
//  CategoryGamesList.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 22.12.2023.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CategoryGamesList {
    struct State: Equatable, Identifiable {
        var id: UUID
        private var category: CategoryType
        var tabIndex: Int { category.tabIndex }
        var categoryName: String { category.localization }
        var categoryMainColor: Color { category.mainColor }
        var categoryFontColor: Color { category.fontColor }
        var games: [GameData]

        init(category: CategoryType) {
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
