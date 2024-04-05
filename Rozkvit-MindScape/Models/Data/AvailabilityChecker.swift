//
//  AvailabilityChecker.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 27.12.2023.
//

import Dependencies

protocol AvailabilityCheckerProtocol {
    typealias GameAvalability = GameData.AvailabilityState

    func gameAvailability(_ game: GameType, gameStatistic: [GameType: Int]) -> GameAvalability
}

extension AvailabilityCheckerProtocol {
    func gameAvailability(_ game: GameType, gameStatistic: [GameType: Int] = [:]) -> GameAvalability {
        gameAvailability(game, gameStatistic: [:])
    }
}

final class AvailabilityChecker: AvailabilityCheckerProtocol {
    func gameAvailability(_ game: GameType, gameStatistic: [GameType : Int]) -> GameAvalability {
        switch game {
        case .pickEmotion:
            return .available
        case .pickEmotion2:
            return gameStatistic[.pickEmotion] ?? 0 >= 80 ? .available : .notAvailable
        case .pickEmotion3:
            return gameAvailability(.pickEmotion2, gameStatistic: gameStatistic) == .available &&
                gameStatistic[.pickEmotion2] ?? 0 >= 80 ? .available : .notAvailable
        case .pickEmotion4:
            return gameAvailability(.pickEmotion3, gameStatistic: gameStatistic) == .available &&
                gameStatistic[.pickEmotion3] ?? 0 >= 80 ? .available : .notAvailable


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

enum AvailabilityCheckerKey: DependencyKey {
    static var liveValue: AvailabilityCheckerProtocol = AvailabilityChecker()
}

extension DependencyValues {
    var availabilityChecker: AvailabilityCheckerProtocol {
        get { self[AvailabilityCheckerKey.self] }
        set { self[AvailabilityCheckerKey.self] = newValue }
    }
}
