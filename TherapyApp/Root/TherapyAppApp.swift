//
//  TherapyAppApp.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct TherapyAppApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootDomain.State()) {
                    RootDomain()
                        ._printChanges()
                }
            )
        }
    }
}
