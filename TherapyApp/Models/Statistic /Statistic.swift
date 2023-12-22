//
//  Statistic.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 19.12.2023.
//

import ComposableArchitecture
import Charts

struct Statistic {
    var chartsData: [StatisticData] = []

    static var mock: Statistic = Statistic(
        chartsData: [.init(name: .criticalThinking, amount: 0.5), .init(name: .emotionalIntelect, amount: 0.5)]
    )
}

// MARK: - Model
struct StatisticData: Equatable {
    var name: StatisticName
    var amount: Double
}

enum StatisticName: Equatable {
    case emotionalIntelect
    case criticalThinking

    var localization: String {
        switch self {
        case .emotionalIntelect:    return localStr("statistic.emotionalIntelect")
        case .criticalThinking:     return localStr("statistic.criticalThinking")
        }
    }
}
