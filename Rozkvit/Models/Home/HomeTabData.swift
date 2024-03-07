//
//  HomeTabData.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import SwiftUI

final class HomeTabData {
    private var gameStatistic: [GameType: Int]
    private var treeBuilder = TreeBuilder()
    private var gameBuilder = GameBuilder()

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
