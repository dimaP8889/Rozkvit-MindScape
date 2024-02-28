//
//  RootView.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<RootDomain>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: RootDomain.Action.tabSelected
                )
            ) {
                CategoriesView(store: store.scope(
                    state: \.categoriesState,
                    action: RootDomain.Action.categories))
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text(localStr("tab.categories"))
                }
                .tag(RootDomain.Tab.categories)

                HomeView(store: store.scope(
                    state: \.homeState,
                    action: RootDomain.Action.home))
                .tabItem {
                    Image(systemName: "house.circle")
                    Text(localStr("tab.home"))
                }
                .tag(RootDomain.Tab.home)

                GamesView(store: store.scope(
                    state: \.gamesState,
                    action: RootDomain.Action.games))
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text(localStr("tab.games"))
                }
                .tag(RootDomain.Tab.games)

                ProfileView(store: store.scope(
                    state: \.profileState,
                    action: RootDomain.Action.profile))
                .tabItem {
                    Image(systemName: "person.fill")
                    Text(localStr("tab.profile"))
                }
                .tag(RootDomain.Tab.profile)
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            store: Store(
                initialState: RootDomain.State()
            ) {
                RootDomain()
            }
        )
    }
}
