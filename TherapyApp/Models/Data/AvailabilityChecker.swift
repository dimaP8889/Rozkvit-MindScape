//
//  AvailabilityChecker.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 27.12.2023.
//

import Foundation

struct AvailabilityChecker {
    func isGameAvailable(_ game: GameType, gameStatistic: [GameType: Int]) -> Bool {
        switch game {
        case .pickEmotion:
            return true
        case .emotionalIntelect1:
            return gameStatistic[.pickEmotion] ?? 0 >= 80
        case .emotionalIntelect2:
            return gameStatistic[.emotionalIntelect1] ?? 0 >= 80
        case .emotionalIntelect3:
            return gameStatistic[.emotionalIntelect2] ?? 0 >= 80


        case .criticalThinking0:
            return true
        case .criticalThinking1:
            return gameStatistic[.criticalThinking0] ?? 0 >= 80
        case .criticalThinking2:
            return gameStatistic[.criticalThinking1] ?? 0 >= 80
        case .criticalThinking3:
            return gameStatistic[.criticalThinking2] ?? 0 >= 80
        }
    }
}
