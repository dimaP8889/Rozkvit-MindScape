//
//  Statistic.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 19.12.2023.
//

import ComposableArchitecture
import SwiftUI
import Charts

struct AppData {
    static var mock: AppData = AppData(
        gameStatistic: [
            .criticalThinking0: 80, .criticalThinking1: 0, .criticalThinking2: 0, .criticalThinking3: 0,
            .pickEmotion: 80, .emotionalIntelect1: 0, .emotionalIntelect2: 0, .emotionalIntelect3: 0
        ]
    )

    var gameStatistic: [GameType: Int] = [:]
    private var availabilityChecker = AvailabilityChecker()

    var chartsData: [StatisticData] {
        CategoryType.allCases.map { type in
            StatisticData(type: type, amount: (1 / Double(CategoryType.allCases.count)))
        }
    }

    var categoriesData: IdentifiedArrayOf<CategoryGamesList.State>  {
        [
            .init(category: .init(type: .emotionalIntelect)),
            .init(category: .init(type: .criticalThinking))
        ]
    }

    func gamesData(for category: CategoryData) -> [GameData] {
        category.games.map {
            GameData(
                type: $0,
                progress: gameStatistic[$0] ?? 0,
                isAvailable: availabilityChecker.isGameAvailable($0, gameStatistic: gameStatistic)
            )
        }
    }
}

// MARK: - Model
struct StatisticData: Equatable, Identifiable {
    var id: String { type.id }
    var type: CategoryType
    var name: String { type.localization }
    var color: Color { type.mainColor }
    var percentage: String { "\(Int(amount * 100))%" }
    var amount: Double
}
