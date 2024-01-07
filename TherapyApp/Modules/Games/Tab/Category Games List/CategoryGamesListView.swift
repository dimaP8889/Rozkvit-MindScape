//
//  CategoryGamesListView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 22.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct CategoryGamesListView: View {
    let store: StoreOf<CategoryGamesList>
    @ObservedObject var viewStore: ViewStore<CategoryGamesList.State, CategoryGamesList.Action>

    init(store: StoreOf<CategoryGamesList>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    var body: some View {
        VStack {
            title
            gamesList
        }
    }
}

// MARK: - Private. Elements
private extension CategoryGamesListView {
    var title: some View {
        Text(viewStore.categoryName)
            .font(.system(size: 18, weight: .semibold, design: .rounded))
    }

    var gamesList: some View {
        VStack(spacing: 0) {
            List {
                ForEach(viewStore.games) { game in
                    GameProgressView(
                        game: game,
                        selectAction: { gameType in
                            viewStore.send(.didSelectGame(gameType))
                        }
                    )
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct CategoryGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGamesListView(
            store: .init(
                initialState: CategoryGamesList.State(category: .init(type: .criticalThinking))
            ) {
                CategoryGamesList()
            }
        )
    }
}
