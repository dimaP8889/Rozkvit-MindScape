//
//  StatisticClient.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 20.12.2023.
//

import ComposableArchitecture
import Combine

@dynamicMemberLookup
struct StatisticsClient {
    public var get: @Sendable () -> Statistic
    public var set: @Sendable (Statistic) async -> Void
    public var stream: @Sendable () -> AsyncStream<Statistic>

    public subscript<Value>(dynamicMember keyPath: KeyPath<Statistic, Value>) -> Value {
        self.get()[keyPath: keyPath]
    }

    public subscript<Value>(
        dynamicMember keyPath: KeyPath<Statistic, Value>
    ) -> AsyncStream<Value> {
        self.stream().map { $0[keyPath: keyPath] }.eraseToStream()
    }

    public func modify(_ operation: (inout Statistic) -> Void) async {
        var userSettings = self.get()
        operation(&userSettings)
        await self.set(userSettings)
    }
}

extension StatisticsClient: DependencyKey {
    static var liveValue: StatisticsClient {
        let initialStatistic = Statistic.mock
        let statistic = LockIsolated(initialStatistic)
        let subject = PassthroughSubject<Statistic, Never>()

        return Self(
            get: {
                statistic.value
            },
            set: { updatedStatistic in
                statistic.withValue {
                    $0 = updatedStatistic
                    subject.send(updatedStatistic)
                }
            },
            stream: {
                subject.values.eraseToStream()
            }
        )
    }

    static var mock: StatisticsClient {
        let initialStatistic = Statistic.mock
        let statistic = LockIsolated(initialStatistic)
        let subject = PassthroughSubject<Statistic, Never>()

        return Self(
            get: {
                statistic.value
            },
            set: { updatedStatistic in
                statistic.withValue {
                    $0 = updatedStatistic
                    subject.send(updatedStatistic)
                }
            },
            stream: {
                subject.values.eraseToStream()
            }
        )
    }
}

extension DependencyValues {
    var statistics: StatisticsClient {
        get { self[StatisticsClient.self] }
        set { self[StatisticsClient.self] = newValue }
    }
}
