//
//  HomeView.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: StoreOf<Home>
    @ObservedObject var viewStore: ViewStore<Home.State, Home.Action>

    init(store: StoreOf<Home>) {
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
            .onFirstAppear { store.send(.onFirstAppear) }
    }
}

// MARK: - Private. Elements
private extension HomeView {
    var backgroundImage: some View {
        viewStore.treeImage
            .resizable()
            .background(PearlGradient(), ignoresSafeAreaEdges: .top)
    }

    var main: some View {
        VStack {
            //daysStreak
            Spacer()
            startButton
            motivationText
        }
        .frame(maxWidth: .infinity)
    }

    var daysStreak: some View {
        Text("30 days streak")
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.mainText)
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .overlay {
                RoundedRectangle(cornerRadius: 23)
                    .stroke(.mainText, lineWidth: 1)
            }
            .padding(.top, 16)
    }

    var startButton: some View {
        Button(
            action: {
                store.send(.didPressStart)
            },
            label: {
                Text(localStr("home.game.start"))
                    .font(.main(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(height: 45)
                    .padding(.horizontal, 40)
            }
        )
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.white)
        )
    }

    var motivationText: some View {
        Text(viewStore.motivationText)
            .font(.main(size: 17, weight: .bold))
            .foregroundStyle(.white)
            .padding(.bottom, 16)
            .padding(.horizontal, 24)
            .multilineTextAlignment(.center)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: .init(
                initialState: .init(),
                reducer: { Home() }
            )
        )
    }
}
