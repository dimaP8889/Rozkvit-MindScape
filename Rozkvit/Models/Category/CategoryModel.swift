//
//  CategoryModel.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 25.12.2023.
//

import SwiftUI

enum CategoryType: Equatable, CaseIterable, Identifiable {
    var id: String { localization }

    case emotionalIntelect
    case criticalThinking
    case logic
    case selfIdentity
    case rationalThinking

    var localization: String {
        switch self {
        case .emotionalIntelect:    return localStr("statistic.emotionalIntelect").lowercased()
        case .criticalThinking:     return localStr("statistic.criticalThinking").lowercased()
        case .logic:                return localStr("statistic.logic").lowercased()
        case .selfIdentity:         return localStr("statistic.selfIdentity").lowercased()
        case .rationalThinking:     return localStr("statistic.rationalThinking").lowercased()
        }
    }

    var mainColor: Color {
        switch self {
        case .emotionalIntelect:    return .emotionalIntelligenceMain
        case .criticalThinking:     return .criticalThinkingMain
        case .logic:                return .logicMain
        case .selfIdentity:         return .selfIdentityMain
        case .rationalThinking:     return .rationalThinkingMain
        }
    }

    var fontColor: Color {
        switch self {
        case .emotionalIntelect:    return .emotionalIntelligenceFont
        case .criticalThinking:     return .criticalThinkingFont
        case .logic:                return .logicFont
        case .selfIdentity:         return .selfIdentityFont
        case .rationalThinking:     return .rationalThinkingFont
        }
    }

    var games: [GameType] {
        switch self {
        case .emotionalIntelect:
            return [.pickEmotion, .emotionalIntelect1, .emotionalIntelect2, .emotionalIntelect3]
        case .criticalThinking:
            return [.criticalThinking0, .criticalThinking1, .criticalThinking2, .criticalThinking3]
        default:
            return []
        }
    }
}

extension CategoryType {
    var tabIndex: Int {
        switch self {
        case .emotionalIntelect:    return 0
        case .criticalThinking:     return 1
        case .logic:                return 2
        case .selfIdentity:         return 3
        case .rationalThinking:     return 4
        }
    }
}

extension Array where Element == CategoryType {
    func category(for game: GameType) -> CategoryType? {
        first { category in
            category.games.contains { $0 == game }
        }
    }
}
