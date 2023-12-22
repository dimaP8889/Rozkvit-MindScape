//
//  Categories.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Categories {
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

// MARK: - State
extension Categories {
    struct State: Equatable {
        var charts: [StatisticData]

        init() {
            @Dependency(\.statistics) var statistics
            self.charts = statistics.chartsData
        }
    }
}

// MARK: - Action
extension Categories {
    enum Action: Equatable {
        case getCharts
    }
}

