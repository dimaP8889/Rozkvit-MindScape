//
//  LocalDatabaseInterface.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import ComposableArchitecture
import SQLite
import Foundation

@DependencyClient
struct LocalDatabaseClient {
    var fetchStats: @Sendable () async throws -> [DatabaseGameStatistic]
    var save: @Sendable (DatabaseGameStatistic) async throws -> Void
}

extension LocalDatabaseClient {
    public static func live(location: Connection.Location? = nil, path: String? = nil) -> Self {
        let _db = UncheckedSendable(Box<Connection?>(wrappedValue: nil))
        @Sendable func db() throws -> Connection {
            if _db.value.wrappedValue == nil {
                let db = try {
                    if let path {
                        return try Connection("\(path)/db.sqlite3")
                    }
                    return try Connection(location ?? .inMemory)
                }()

                let stats = Table("stats")

                let id = Expression<UUID>("id")
                let game = Expression<String>("game")
                let result = Expression<Int>("result")
                let date = Expression<Int>("date")

                try db.run(stats.create(ifNotExists: true) { t in
                    t.column(id, unique: true)
                    t.column(game)
                    t.column(result)
                    t.column(date)
                })
                _db.value.wrappedValue = db
            }

            return _db.value.wrappedValue!
        }

        return Self(
            fetchStats: { try db().fetchStats() },
            save: { try db().save(gameResult: $0) }
        )
    }
}

private extension Connection {
    func fetchStats() throws -> [DatabaseGameStatistic] {
        let db = self
        let stats = Table("stats")

        let game = Expression<String>("game")
        let result = Expression<Int>("result")
        let date = Expression<Int>("date")

        let mappedStats: [DatabaseGameStatistic?] = try db.prepare(stats).map { stat in
            guard let game = GameType(rawValue: stat[game]) else { return nil }
            let date = stat[date]
            let result = stat[result]

            return DatabaseGameStatistic(game: game, date: date, result: result)
        }

        return mappedStats.compactMap { $0 }
    }

    func save(gameResult: DatabaseGameStatistic) throws {
        @Dependency(\.uuid) var uuidGenerator

        let db = self
        let stats = Table("stats")

        let id = Expression<UUID>("id")
        let game = Expression<String>("game")
        let result = Expression<Int>("result")
        let date = Expression<Int>("date")

        let insert = stats.insert(
            id <- uuidGenerator.callAsFunction(),
            game <- gameResult.game.rawValue,
            result <- gameResult.result,
            date <- gameResult.date
        )
        try db.run(insert)
    }
}

private final class Box<Value> {
    var wrappedValue: Value
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}
