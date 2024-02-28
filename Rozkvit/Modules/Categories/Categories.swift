//
//  Categories.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct Categories {
    struct State: Equatable {
        typealias ChartsData = Categories.ChartsData

        var charts: [ChartsData]
        var selectedAngle: Double? = nil

        init() {
            @Dependency(\.appData) var appData
            self.charts = appData.categoriesTabData.chartsData
        }
    }

    enum Action: Equatable {
        case didSelectChart(angle: Double?)
        case showGamesFor(CategoryType)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .didSelectChart(angle):
                guard let angle else { return .none }
                state.selectedAngle = angle
                guard let selected = findSelectedCategory(angle, charts: state.charts) else { return .none }
                return .send(.showGamesFor(selected))

            case .showGamesFor:
                return .none
            }
        }
    }
}

// MARK: - Middlewares
private extension Categories {
    func findSelectedCategory(_ selectedAngle: Double, charts: [ChartsData]) -> CategoryType? {
        var cumulative = 0.0

        let cumulativeData = charts.map {
            let newCumulative = cumulative + Double($0.amount)
            let result = (category: $0.type, range: cumulative ..< newCumulative)
            cumulative = newCumulative
            return result
        }

        if let selectedIndex = cumulativeData
            .firstIndex(where: { $0.range.contains(selectedAngle) }) {
            return charts[selectedIndex].type
        }
        return nil
    }
}

// MARK: - Model
extension Categories {
    struct ChartsData: Equatable, Identifiable {
        var id: String { type.id }
        var type: CategoryType
        var name: String { type.localization }
        var color: Color { type.mainColor }
        var percentage: String { "\(Int(amount * 100))%" }
        var amount: Double
    }
}
