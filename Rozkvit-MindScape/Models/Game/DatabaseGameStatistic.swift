//
//  GameStatistic.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import Foundation

struct DatabaseGameStatistic: Equatable {
    let game: GameType
    let date: Int
    let result: Int
}

extension Array where Element == DatabaseGameStatistic {
    func toLastSessionStatistic() -> [GameType: Int] {
        let sortedStatistic = self.sorted { $0.date < $1.date }
        var gamesStatistic: [GameType: Int] = [:]
        sortedStatistic.forEach {
            gamesStatistic[$0.game] = $0.result
        }
        return gamesStatistic
    }
}

extension Dictionary where Key == GameType, Value == Int {
    func toDatabaseStatistic(with date: Int) -> [DatabaseGameStatistic] {
        return self.map { game, result in
            DatabaseGameStatistic(game: game, date: date, result: result)
        }
    }
}
