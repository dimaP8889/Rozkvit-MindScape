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
    let isAvailable: Bool
    var image: Image { type.mainImage }
    var title: String { type.title }

    init(type: GameType, progress: Int, isAvailable: Bool) {
        self.type = type
        self.progress = GameStarProgress(progress: progress)
        self.isAvailable = isAvailable
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
}

enum GameType: Equatable, CaseIterable {
    // Emotional Intelect
    case pickEmotion
    case emotionalIntelect1
    case emotionalIntelect2
    case emotionalIntelect3

    // Critical Thinking
    case criticalThinking0
    case criticalThinking1
    case criticalThinking2
    case criticalThinking3

    var title: String {
        switch self {
        case .pickEmotion:
            return localStr("game.pickEmotion.title")
        case .emotionalIntelect1:
            return "Emotional Intelect1"
        case .emotionalIntelect2:
            return "Emotional Intelect2"
        case .emotionalIntelect3:
            return "Emotional Intelect3"


        case .criticalThinking0:
            return "Critical Thinking0"
        case .criticalThinking1:
            return "Critical Thinking1"
        case .criticalThinking2:
            return "Critical Thinking2"
        case .criticalThinking3:
            return "Critical Thinking3"
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
        case .criticalThinking1:
            return Image(.surprise2)
        case .criticalThinking2:
            return Image(.calmDown)
        case .criticalThinking3:
            return Image(.anger2)
        }
    }
}
