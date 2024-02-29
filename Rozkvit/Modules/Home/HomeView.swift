//
//  HomeView.swift
//  Rozkvit
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
            .onAppear { store.send(.onAppear) }
    }
}

// MARK: - Private. Elements
private extension HomeView {
    var backgroundImage: some View {
        viewStore.treeImage
            .resizable()
            .ignoresSafeArea(edges: .top)
    }

    var main: some View {
        VStack {
            //daysStreak
            Spacer()
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

    var motivationText: some View {
        Text(viewStore.motivationText)
            .font(.main(size: 17, weight: .bold))
            .foregroundStyle(.white)
            .padding(.bottom, 48)
            .padding(.horizontal, 50)
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
