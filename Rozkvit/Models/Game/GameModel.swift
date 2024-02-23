//
//  GameModel.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 26.12.2023.
//

import SwiftUI

struct GameData: Identifiable, Equatable {
    let type: GameType
    let progress: GameStarProgress
    let availabilityState: AvailabilityState
    var image: Image { type.mainImage }
    var title: String { type.title }

    init(type: GameType, progress: Int, availabilityState: AvailabilityState) {
        self.type = type
        self.progress = GameStarProgress(progress: progress)
        self.availabilityState = availabilityState
    }

    var id: String {
        type.title
    }

    enum GameStarProgress {
        case noStars
        case oneStar
        case twoStars
        case threeStars

        init(progress: Int) {
            if progress == 0 {
                self = .noStars
            } else if progress > 0, progress < 50 {
                self = .oneStar
            } else if progress >= 50, progress < 80 {
                self = .twoStars
            } else {
                self = .threeStars
            }
        }

        var firstStar: Image {
            switch self {
            case .noStars:      return Image(.starEmptyIc)
            case .oneStar:      return Image(.starFilledIc)
            case .twoStars:     return Image(.starFilledIc)
            case .threeStars:   return Image(.starFilledIc)
            }
        }

        var secondStar: Image {
            switch self {
            case .noStars:      return Image(.starEmptyIc)
            case .oneStar:      return Image(.starEmptyIc)
            case .twoStars:     return Image(.starFilledIc)
            case .threeStars:   return Image(.starFilledIc)
            }
        }

        var thirdStar: Image {
            switch self {
            case .noStars:      return Image(.starEmptyIc)
            case .oneStar:      return Image(.starEmptyIc)
            case .twoStars:     return Image(.starEmptyIc)
            case .threeStars:   return Image(.starFilledIc)
            }
        }
    }

    enum AvailabilityState {
        case available
        case notAvailable
        case comingSoon

        var isGameAvailable: Bool {
            self == .available
        }

        var unavailableText: String {
            switch self {
            case .available:    return ""
            case .notAvailable: return localStr("game.unavailable.description")
            case .comingSoon:  return localStr("game.comingsoon.description")
            }
        }
    }
}

enum GameType: Equatable, CaseIterable {
    // Emotional Intelect
    case pickEmotion
    case emotionalIntelect1
    case emotionalIntelect2
    case emotionalIntelect3

    // Critical Thinking
    case criticalThinking0

    // Logic
    case logic0

    // Self Identity
    case selfIdentity0

    // Rational Thinking
    case rationalThinking0

    var title: String {
        switch self {
        case .pickEmotion:
            return localStr("game.pickEmotion.title")
        case .emotionalIntelect1:
            return localStr("game.pickEmotion.title") + " 2"
        case .emotionalIntelect2:
            return localStr("game.pickEmotion.title") + " 3"
        case .emotionalIntelect3:
            return localStr("game.pickEmotion.title") + " 4"


        case .criticalThinking0:
            return localStr("statistic.criticalThinking")

        case .logic0:
            return localStr("statistic.logic")

        case .selfIdentity0:
            return localStr("statistic.selfIdentity")

        case .rationalThinking0:
            return localStr("statistic.rationalThinking")
        }
    }

    var mainImage: Image {
        switch self {
        case .pickEmotion:
            return Image(.happiness4)
        case .emotionalIntelect1:
            return Image(.boyAndWall)
        case .emotionalIntelect2:
            return Image(.anger1)
        case .emotionalIntelect3:
            return Image(.fear2)

        case .criticalThinking0:
            return Image(.sadness3)

        case .logic0:
            return Image(.happiness1)

        case .selfIdentity0:
            return Image(.fear1)

        case .rationalThinking0:
            return Image(.surprise1)
        }
    }
}
