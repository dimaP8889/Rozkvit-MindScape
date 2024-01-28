//
//  StatisticClient.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 20.12.2023.
//

import ComposableArchitecture
import Combine

@dynamicMemberLookup
struct AppDataClient {
    var get: @Sendable () -> AppData
    var setGameStatistic: @Sendable (GameType, Int) async -> Void
    var stream: @Sendable () -> AsyncStream<AppData>

    public subscript<Value>(dynamicMember keyPath: KeyPath<AppData, Value>) -> Value {
        self.get()[keyPath: keyPath]
    }

    public subscript<Value>(
        dynamicMember keyPath: KeyPath<AppData, Value>
    ) -> AsyncStream<Value> {
        self.stream().map { $0[keyPath: keyPath] }.eraseToStream()
    }

//    public func modify(_ operation: (inout AppData) -> Void) async {
//        var appData = self.get()
//        operation(&appData)
//        await self.set(appData)
//    }
}

extension AppDataClient: DependencyKey {
    static var liveValue: AppDataClient {
        let initialData = AppData.mock
        let appData = LockIsolated(initialData)
        let subject = PassthroughSubject<AppData, Never>()

        return Self(
            get: {
                appData.value
            },
            setGameStatistic: { game, result in
                appData.withValue {
                    $0.gameStatistic[game] = result
                    subject.send($0)
                }
            },
            stream: {
                subject.values.eraseToStream()
            }
        )
    }

    static var mock: AppDataClient {
        let initialData = AppData.mock
        let appData = LockIsolated(initialData)
        let subject = PassthroughSubject<AppData, Never>()

        return Self(
            get: {
                appData.value
            },
            setGameStatistic: { game, result in
                appData.withValue {
                    $0.gameStatistic[game] = result
                    subject.send($0)
                }
            },
            stream: {
                subject.values.eraseToStream()
            }
        )
    }
}

extension DependencyValues {
    var appData: AppDataClient {
        get { self[AppDataClient.self] }
        set { self[AppDataClient.self] = newValue }
    }
}
