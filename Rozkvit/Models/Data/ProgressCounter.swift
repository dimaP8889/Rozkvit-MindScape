//
//  ProgressCounter.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 29.02.2024.
//

import Foundation

final class ProgressCounter {
    private var gamesAvailabilityChecker = AvailabilityChecker()

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
