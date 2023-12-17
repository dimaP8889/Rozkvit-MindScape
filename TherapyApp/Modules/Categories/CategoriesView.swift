//
//  CategoriesView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct CategoriesView: View {
    let store: StoreOf<Categories>

    var body: some View {
        Text("Categories Tab")
    }
}

// MARK: - Private. Elements
private extension CategoriesView {
    
}

// MARK: - Private. Actions
private extension CategoriesView {
    
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            store: .init(
                initialState: .init(),
                reducer: { }
            )
        )
    }
}
