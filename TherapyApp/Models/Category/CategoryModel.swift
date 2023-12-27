//
//  CategoryModel.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 25.12.2023.
//

import Foundation

struct CategoryData: Equatable {
    var type: CategoryType
    var name: String { type.localization }
    var games: [GameType] {
        switch type {
        case .emotionalIntelect:
            return [.pickEmotion, .emotionalIntelect1, .emotionalIntelect2, .emotionalIntelect3]
        case .criticalThinking:
            return [.criticalThinking0, .criticalThinking1, .criticalThinking2, .criticalThinking3]
        }
    }

    init(type: CategoryType) {
        self.type = type
    }
}

enum CategoryType: Equatable, CaseIterable {
    case emotionalIntelect
    case criticalThinking

    var localization: String {
        switch self {
        case .emotionalIntelect:    return localStr("statistic.emotionalIntelect")
        case .criticalThinking:     return localStr("statistic.criticalThinking")
        }
    }
}


extension CategoryType {
    var tabIndex: Int {
        switch self {
        case .emotionalIntelect:    return 0
        case .criticalThinking:     return 1
        }
    }
}
