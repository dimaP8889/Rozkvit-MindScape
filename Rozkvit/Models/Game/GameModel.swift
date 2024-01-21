//
//  GameModel.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 26.12.2023.
//

import Foundation

struct GameData: Identifiable, Equatable {
    let type: GameType
    let progress: Int
    let isAvailable: Bool

    var id: String {
        type.title
    }
}

enum GameType: CaseIterable {
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
}
