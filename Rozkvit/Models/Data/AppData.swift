//
//  Statistic.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 19.12.2023.
//

import ComposableArchitecture
import SwiftUI
import Charts

struct AppData: Equatable {
    static var mock: AppData = AppData(
        gameStatistic: [
            .pickEmotion: 0, .emotionalIntelect1: 0, .emotionalIntelect2: 0, .emotionalIntelect3: 0
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
        let categoriesArray: [CategoryGamesList.State] = CategoryType.allCases.map {
            .init(category: $0)
        }
        return .init(uniqueElements: categoriesArray)
    }

    func gamesData(for category: CategoryType) -> [GameData] {
        category.games.map {
            GameData(
                type: $0,
                progress: gameStatistic[$0] ?? 0,
                availabilityState: availabilityChecker.gameAvailability($0, gameStatistic: gameStatistic)
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
