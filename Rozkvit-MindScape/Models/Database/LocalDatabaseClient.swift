//
//  LocalDatabaseClient.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import ComposableArchitecture
import SQLite
import Foundation

extension DependencyValues {
    var database: LocalDatabaseClient {
        get { self[LocalDatabaseClient.self] }
        set { self[LocalDatabaseClient.self] = newValue }
    }
}

extension LocalDatabaseClient: TestDependencyKey {
    static var testValue: LocalDatabaseClient = Self.mock
}

extension LocalDatabaseClient {
    public static var mock: Self {
        return Self(
            fetchStats: { [] },
            save: { _ in }
        )
    }
}

extension LocalDatabaseClient {
    public static let liveValue = {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        return Self.live(path: path)
    }()
}
