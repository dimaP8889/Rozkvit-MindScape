//
//  Statistic.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 19.12.2023.
//

import ComposableArchitecture
import SwiftUI
import Charts

struct AppData: Equatable {
    var databaseGameStatistic: [DatabaseGameStatistic] = []
    var gameStatistic: [GameType: Int] {
        databaseGameStatistic.toLastSessionStatistic()
    }

    var categoriesTabData: CategoriesTabData {
        CategoriesTabData()
    }

    var homeTabData: HomeTabData {
        HomeTabData(gameStatistic: gameStatistic)
    }

    var gamesTabData: GamesTabData {
        GamesTabData(gameStatistic: gameStatistic)
    }

    var profileTabData: ProfileTabData {
        ProfileTabData(databaseStatistic: databaseGameStatistic)
    }
}
