//
//  Profile.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct Profile {
    struct State: Equatable {
        var fullName: String
        var todayCorrectData: [ProfileChartData] = []
        var allTimeCorrectData: [ProfileChartData] = []
        var effectivenessData: [ProfileChartData] = []

        init() {
            @Dependency(\.appData) var appData

            self.fullName = "Happy Doggy"
            updateCharts(for: appData.get())
        }

        mutating func updateCharts(for appData: AppData) {
            todayCorrectData = appData.profileTabData.todayCorrectData()
            allTimeCorrectData = appData.profileTabData.allTimeCorrectData()
            effectivenessData = appData.profileTabData.effectivenessChartByDay()
        }
    }

    enum Action: Equatable {
        case didUpdateData(AppData)
        case onAppear
    }

    @Dependency(\.appData) var appData

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    for await appData in self.appData.stream() {
                        await send(.didUpdateData(appData))
                    }
                }

            case let .didUpdateData(appData):
                state.updateCharts(for: appData)
                return .none
            }
        }
    }
}

struct ProfileChartData: Equatable, Hashable {
    let name: String
    let amount: Int
    let color: Color?

    internal init(name: String, amount: Int, color: Color? = nil) {
        self.name = name
        self.amount = amount
        self.color = color
    }
}
