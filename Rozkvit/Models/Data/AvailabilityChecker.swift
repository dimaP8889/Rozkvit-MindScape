//
//  AvailabilityChecker.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 27.12.2023.
//

import Foundation

struct AvailabilityChecker: Equatable {
    typealias GameAvalability = GameData.AvailabilityState
    
    func gameAvailability(_ game: GameType, gameStatistic: [GameType: Int]) -> GameAvalability {
        switch game {
        case .pickEmotion:
            return .available
        case .emotionalIntelect1:
            return gameStatistic[.pickEmotion] ?? 0 >= 80 ? .available : .notAvailable
        case .emotionalIntelect2:
            return gameAvailability(.emotionalIntelect1, gameStatistic: gameStatistic) == .available &&
                gameStatistic[.emotionalIntelect1] ?? 0 >= 80 ? .available : .notAvailable
        case .emotionalIntelect3:
            return gameAvailability(.emotionalIntelect2, gameStatistic: gameStatistic) == .available &&
                gameStatistic[.emotionalIntelect2] ?? 0 >= 80 ? .available : .notAvailable


        case .criticalThinking0:
            return .comingSoon

        case .logic0:
            return .comingSoon

        case .selfIdentity0:
            return .comingSoon

        case .rationalThinking0:
            return .comingSoon
        }
    }
}
