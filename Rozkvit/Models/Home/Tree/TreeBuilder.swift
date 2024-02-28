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

        let allTrees: [Image] = [
            Image(.tree0), Image(.tree1), Image(.tree2), Image(.tree3), Image(.tree4),
            Image(.tree5), Image(.tree6), Image(.tree7), Image(.tree8), Image(.tree9),
            Image(.tree10)
        ]
        let treeIndex = Int(Double(allTrees.count) * percentage)
        return treeIndex > 0 ? allTrees[treeIndex - 1] : allTrees[treeIndex]
    }
}
