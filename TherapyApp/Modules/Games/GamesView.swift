//
//  GamesView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct GamesView: View {
    let store: StoreOf<Games>

    var body: some View {
        Text("Games Tab")
    }
}

// MARK: - Private. Elements
private extension GamesView {
    
}

// MARK: - Private. Actions
private extension GamesView {
    
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView(
            store: .init(
                initialState: .init(),
                reducer: { }
            )
        )
    }
}
