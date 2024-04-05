//
//  GameBuilder.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 05.01.2024.
//

import Dependencies

protocol GameBuilderProtocol {
    func createGame(for type: GameType) -> GameEnvironment
    func createNextGame(for statistic: [GameType: Int]) -> GameEnvironment
}

final class GameBuilder: GameBuilderProtocol {
    @Dependency(\.availabilityChecker) var availabilityChecker
    @Dependency(\.pickEmotionsGameFabric) var pickEmotionsGameFabric

    func createGame(for type: GameType) -> GameEnvironment {
        pickEmotionsGameFabric.createGame(of: type)
    }

    func createNextGame(for statistic: [GameType: Int]) -> GameEnvironment {
        let nextGame = nextGame(for: statistic)
        return createGame(for: nextGame)
    }

    private func nextGame(for statistic: [GameType: Int]) -> GameType {
        var prevGame: GameType = .pickEmotion
        for game in GameType.allCases {
            if availabilityChecker.gameAvailability(game, gameStatistic: statistic) != .available {
                return prevGame
            }
            prevGame = game
        }
        return prevGame
    }
}

enum GameBuilderKey: DependencyKey {
    static var liveValue: GameBuilderProtocol = GameBuilder()
}

extension DependencyValues {
    var gameBuilder: GameBuilderProtocol {
        get { self[GameBuilderKey.self] }
        set { self[GameBuilderKey.self] = newValue }
    }
}
