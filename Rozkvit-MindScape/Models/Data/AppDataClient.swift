//
//  StatisticClient.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 20.12.2023.
//

import ComposableArchitecture
import Combine

extension DependencyValues {
    var appData: AppDataClient {
        get { self[AppDataClientKey.self] }
        set { self[AppDataClientKey.self] = newValue }
    }
}

@dynamicMemberLookup
struct AppDataClient {
    var get: @Sendable () -> AppData
    var addGameStatistic: @Sendable (DatabaseGameStatistic) async -> Void
    var stream: @Sendable () -> AsyncStream<AppData>

    public subscript<Value>(dynamicMember keyPath: KeyPath<AppData, Value>) -> Value {
        self.get()[keyPath: keyPath]
    }

    public subscript<Value>(
        dynamicMember keyPath: KeyPath<AppData, Value>
    ) -> AsyncStream<Value> {
        self.stream().map { $0[keyPath: keyPath] }.eraseToStream()
    }
}

enum AppDataClientKey: DependencyKey {
    static let liveValue: AppDataClient = AppDataClient.liveValue
}

extension AppDataClient {
    static var liveValue: AppDataClient {
        let initialData = AppData()
        let appData = LockIsolated(initialData)
        let subject = PassthroughSubject<AppData, Never>()

        return Self(
            get: {
                appData.value
            },
            addGameStatistic: { stats in
                appData.withValue {
                    $0.databaseGameStatistic.append(stats)
                    subject.send($0)
                }
            },
            stream: {
                subject.values.eraseToStream()
            }
        )
    }
}
