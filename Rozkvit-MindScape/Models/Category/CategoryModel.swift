//
//  CategoryModel.swift
//  Rozkvit-MindScape
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
        case .emotionalIntelect:    return localStr("categories.emotionalIntelect").lowercased()
        case .criticalThinking:     return localStr("categories.criticalThinking").lowercased()
        case .logic:                return localStr("categories.logic").lowercased()
        case .selfIdentity:         return localStr("categories.selfIdentity").lowercased()
        case .rationalThinking:     return localStr("categories.rationalThinking").lowercased()
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
            return [.pickEmotion, .pickEmotion2, .pickEmotion3, .pickEmotion4]
        case .criticalThinking:
            return [.criticalThinking0]
        case .logic:
            return [.logic0]
        case .selfIdentity:
            return [.selfIdentity0]
        case .rationalThinking:
            return [.rationalThinking0]
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
