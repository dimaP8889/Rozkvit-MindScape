//
//  HomeTabData.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import SwiftUI
import Dependencies

final class HomeTabData {
    private var gameStatistic: [GameType: Int]
    @Dependency(\.treeBuilder) var treeBuilder
    @Dependency(\.gameBuilder) var gameBuilder

    init(gameStatistic: [GameType : Int]) {
        self.gameStatistic = gameStatistic
    }

    var treeImage: Image {
        treeBuilder.tree(for: gameStatistic)
    }

    var motivationText: String {
        treeBuilder.motivation(for: gameStatistic)
    }

    var nextGame: GameEnvironment {
        gameBuilder.createNextGame(for: gameStatistic)
    }
}
