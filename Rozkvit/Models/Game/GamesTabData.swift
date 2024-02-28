//
//  GamesData.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import ComposableArchitecture

final class GamesTabData {
    private var availabilityChecker = AvailabilityChecker()
    private var gameStatistic: [GameType: Int]

    init(gameStatistic: [GameType : Int]) {
        self.gameStatistic = gameStatistic
    }

    var categories: IdentifiedArrayOf<CategoryGamesList.State>  {
        let categoriesArray: [CategoryGamesList.State] = CategoryType.allCases.map {
            .init(category: $0, gamesData: data(for: $0))
        }
        return .init(uniqueElements: categoriesArray)
    }

    func data(for category: CategoryType) -> [GameData] {
        category.games.map {
            GameData(
                type: $0,
                progress: gameStatistic[$0] ?? 0,
                availabilityState: availabilityChecker.gameAvailability($0, gameStatistic: gameStatistic)
            )
        }
    }
}
