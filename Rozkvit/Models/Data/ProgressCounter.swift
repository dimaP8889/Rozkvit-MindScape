//
//  ProgressCounter.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 29.02.2024.
//

import Foundation

final class ProgressCounter {
    typealias StarProgress = GameData.GameStarProgress
    private var gamesAvailabilityChecker = AvailabilityChecker()

    // Count progress relatively to stars earned
    func progressStarsPercentage(for statistic: [GameType: Int]) -> Double {
        var allGamesProgress: [GameType: Int] = [:]
        GameType.allCases.forEach { type in
            if gamesAvailabilityChecker.gameAvailability(type) != .comingSoon {
                let stars = StarProgress(progress: statistic[type] ?? 0).starsAmount
                allGamesProgress[type] = stars
            }
        }

        let maxValue = allGamesProgress.reduce(0.0) { partialResult, dict in
            partialResult + 3
        }
        let curValue = allGamesProgress.reduce(0.0) { partialResult, dict in
            partialResult + Double(dict.value)
        }
        let percentage = maxValue == 0 ? 0 : curValue / maxValue
        return percentage
    }

    func progressPercentage(for statistic: [GameType: Int]) -> Double {
        var allGamesStatistic: [GameType: Int] = [:]
        GameType.allCases.forEach { type in
            if gamesAvailabilityChecker.gameAvailability(type) != .comingSoon {
                allGamesStatistic[type] = statistic[type] ?? 0
            }
        }

        let maxValue = allGamesStatistic.reduce(0.0) { partialResult, dict in
            partialResult + 100
        }

        let curValue = allGamesStatistic.reduce(0.0) { partialResult, dict in
            partialResult + Double(dict.value)
        }
        let percentage = maxValue == 0 ? 0 : curValue / maxValue
        return percentage
    }
}
