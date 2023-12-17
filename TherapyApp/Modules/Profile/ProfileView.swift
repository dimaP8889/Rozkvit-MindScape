//
//  ProfileView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct ProfileView: View {
    let store: StoreOf<Profile>

    var body: some View {
        Text("Profile Tab")
    }
}

// MARK: - Private. Elements
private extension ProfileView {
    
}

// MARK: - Private. Actions
private extension ProfileView {
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            store: .init(
                initialState: .init(),
                reducer: { }
            )
        )
    }
}
