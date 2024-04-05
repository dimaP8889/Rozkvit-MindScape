//
//  LocalDatabaseClient.swift
//  Rozkvit-MindScape
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

extension DependencyValues {
    var database: LocalDatabaseClient {
        get { self[LocalDatabaseKey.self] }
        set { self[LocalDatabaseKey.self] = newValue }
    }
}

enum LocalDatabaseKey: DependencyKey {
    public static let liveValue: LocalDatabaseClient = {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        return LocalDatabaseClient.live(path: path)
    }()
}
