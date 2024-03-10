//
//  RozkvitMindScapeApp.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct RozkvitMindScape: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootDomain.State()) {
                    RootDomain()
                        ._printChanges()
                } withDependencies: {
                    $0.appData = .liveValue
                    $0.database = .liveValue
                }
            )
        }
    }
}
