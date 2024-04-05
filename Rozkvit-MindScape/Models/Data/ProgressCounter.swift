//
//  ProgressCounter.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 29.02.2024.
//

import Dependencies

protocol ProgressCounterProtocol {
    func progressStarsPercentage(for statistic: [GameType: Int]) -> Double
    func progressPercentage(for statistic: [GameType: Int]) -> Double
}


final class ProgressCounter: ProgressCounterProtocol {
    typealias StarProgress = GameData.GameStarProgress
    @Dependency(\.availabilityChecker) var availabilityChecker

    // Count progress relatively to stars earned
    func progressStarsPercentage(for statistic: [GameType: Int]) -> Double {
        var allGamesProgress: [GameType: Int] = [:]
        GameType.allCases.forEach { type in
            if availabilityChecker.gameAvailability(type) != .comingSoon {
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
            if availabilityChecker.gameAvailability(type) != .comingSoon {
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

enum ProgressCounterKey: DependencyKey {
    static var liveValue: ProgressCounterProtocol = ProgressCounter()
}

extension DependencyValues {
    var progressCounter: ProgressCounterProtocol {
        get { self[ProgressCounterKey.self] }
        set { self[ProgressCounterKey.self] = newValue }
    }
}
