//
//  TreeBuilder.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 28.01.2024.
//

import Foundation
import SwiftUI

final class TreeBuilder {
    private var progressCounter = ProgressCounter()

    func tree(for statistic: [GameType: Int]) -> Image {
        let percentage = progressCounter.progressStarsPercentage(for: statistic)

        let allTrees: [Image] = [
            Image(.tree0), Image(.tree1), Image(.tree2), Image(.tree3), Image(.tree4),
            Image(.tree5), Image(.tree6), Image(.tree7), Image(.tree8), Image(.tree9),
            Image(.tree10)
        ]
        let treeIndex = Int(Double(allTrees.count) * percentage)
        return treeIndex > 0 ? allTrees[treeIndex - 1] : allTrees[treeIndex]
    }

    func motivation(for statistic: [GameType: Int]) -> String {
        let percentage = progressCounter.progressPercentage(for: statistic)
        switch percentage {
        case ...0.33:       return localStr("home.motivation.text.1")
        case 0.33...0.7:    return localStr("home.motivation.text.2")
        case 0.7...:        return localStr("home.motivation.text.3")
        default:            return localStr("home.motivation.text.1")
        }
    }
}
