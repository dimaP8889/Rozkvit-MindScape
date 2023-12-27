//
//  HomeView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    let store: StoreOf<Home>

    var body: some View {
        main
            .background(backgroundImage)
    }
}

// MARK: - Private. Elements
private extension HomeView {
    var backgroundImage: some View {
        Image("tree_6")
            .resizable()
    }

    var main: some View {
        VStack {
            daysSteak
            Spacer()
            motivationText
        }
    }

    var daysSteak: some View {
        HStack {
            Spacer()
            Text("30 days steak")
                .padding(.trailing, 16)
                .padding(.top, 16)
        }
    }

    var motivationText: some View {
        Text(localStr("home.motivation.text"))
            .padding(.bottom, 60)
            .padding(.horizontal, 50)
            .multilineTextAlignment(.center)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store: .init(
                initialState: .init(),
                reducer: { }
            )
        )
    }
}
