//
//  AvailabilityChecker.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 27.12.2023.
//

import Foundation

struct AvailabilityChecker: Equatable {
    func isGameAvailable(_ game: GameType, gameStatistic: [GameType: Int]) -> Bool {
        switch game {
        case .pickEmotion:
            return true
        case .emotionalIntelect1:
            return gameStatistic[.pickEmotion] ?? 0 >= 80
        case .emotionalIntelect2:
            return isGameAvailable(.emotionalIntelect1, gameStatistic: gameStatistic) &&
                gameStatistic[.emotionalIntelect1] ?? 0 >= 80
        case .emotionalIntelect3:
            return isGameAvailable(.emotionalIntelect2, gameStatistic: gameStatistic) &&
                gameStatistic[.emotionalIntelect2] ?? 0 >= 80


        case .criticalThinking0:
            return true
        case .criticalThinking1:
            return gameStatistic[.criticalThinking0] ?? 0 >= 80
        case .criticalThinking2:
            return isGameAvailable(.criticalThinking1, gameStatistic: gameStatistic) &&
                gameStatistic[.criticalThinking1] ?? 0 >= 80
        case .criticalThinking3:
            return isGameAvailable(.criticalThinking2, gameStatistic: gameStatistic) &&
                gameStatistic[.criticalThinking2] ?? 0 >= 80
        }
    }
}
