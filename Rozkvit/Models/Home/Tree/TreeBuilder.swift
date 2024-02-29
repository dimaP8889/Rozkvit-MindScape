//
//  TreeBuilder.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 28.01.2024.
//

import Foundation
import SwiftUI

final class TreeBuilder {
    private var gamesAvailabilityChecker = AvailabilityChecker()

    func tree(for statistic: [GameType: Int]) -> Image {
        let percentage = progressPercentage(for: statistic)

        let allTrees: [Image] = [
            Image(.tree0), Image(.tree1), Image(.tree2), Image(.tree3), Image(.tree4),
            Image(.tree5), Image(.tree6), Image(.tree7), Image(.tree8), Image(.tree9),
            Image(.tree10)
        ]
        let treeIndex = Int(Double(allTrees.count) * percentage)
        return treeIndex > 0 ? allTrees[treeIndex - 1] : allTrees[treeIndex]
    }

    func motivation(for statistic: [GameType: Int]) -> String {
        let percentage = progressPercentage(for: statistic)
        switch percentage {
        case ...0.33:       return localStr("home.motivation.text.1")
        case 0.33...0.7:    return localStr("home.motivation.text.2")
        case 0.7...:        return localStr("home.motivation.text.3")
        default:            return localStr("home.motivation.text.1")
        }
    }

    private func progressPercentage(for statistic: [GameType: Int]) -> Double {
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
