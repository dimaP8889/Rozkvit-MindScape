//
//  CategoryGamesListView.swift
//  Rozkvit
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
            subtitle
            gamesList
        }
    }
}

// MARK: - Private. Elements
private extension CategoryGamesListView {
    var title: some View {
        Text(localStr("game.category.title"))
            .font(.main(size: 17, weight: .bold))
            .foregroundStyle(viewStore.categoryFontColor)
    }

    var subtitle: some View {
        Text(viewStore.categoryName)
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(viewStore.categoryFontColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(viewStore.categoryMainColor)
            )
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
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.grouped)
            .background(.clear)
        }
    }
}

struct CategoryGamesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGamesListView(
            store: .init(
                initialState: CategoryGamesList.State(category: .emotionalIntelect)
            ) {
                CategoryGamesList()
            }
        )
        .background(PearlGradient())
    }
}
