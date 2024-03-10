//
//  CategoryGamesList.swift
//  Rozkvit-MindScape
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

        init(category: CategoryType, gamesData: [GameData]) {
            @Dependency(\.uuid) var uuid
            self.id = uuid.callAsFunction()
            self.category = category
            self.games = gamesData
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
