//
//  GamesView.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct GamesView: View {
    let store: StoreOf<Games>
    @ObservedObject var viewStore: ViewStore<Games.State, Games.Action>

    init(store: StoreOf<Games>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    var body: some View {
        main
            .background(backgroundImage)
            .fullScreenCover(
                store: self.store.scope(
                    state: \.$destination.selectedGame,
                    action: \.destination.selectedGame
                )
            ) { store in
                GameEventView(store: store)
            }
    }
}

// MARK: - Private. Elements
private extension GamesView {
    var backgroundImage: some View {
        Image(.categoriesBg)
            .resizable()
    }

    var main: some View {
        VStack {
            title
            categories
        }
    }

    var title: some View {
        Text(localStr("game.pickGame"))
            .font(.system(size: 30, weight: .bold, design: .monospaced))
    }

    var categories: some View {
        TabView(selection: selectedItem) {
            ForEachStore(
                store.scope(state: \.categories, action: \.categories)
            ) { viewStore in
                CategoryGamesListView(store: viewStore)
                    .tag(ViewStore(viewStore, observe: { $0 }).tabIndex)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// MARK: - Binding Value
extension GamesView {
    var selectedItem: Binding<Int> {
        .init(
            get: { viewStore.selectedCategoryIndex },
            set: { viewStore.send(.didSelectCategoryIndex($0)) }
        )
    }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView(
            store: .init(
                initialState: Games.State()
            ) {
                Games()
            }
        )
    }
}
