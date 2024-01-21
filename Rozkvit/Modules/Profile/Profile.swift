//
//  Profile.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture

@Reducer
struct Profile {
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}

struct ProfileChartData: Equatable {
    let name: String
    let amount: Int

    static var moodMock: [ProfileChartData] = {
        [.init(name: "Happy", amount: 10), .init(name: "Sad", amount: 3),
            .init(name: "Angry", amount: 7), .init(name: "Content", amount: 12)]
    }()

    static var stressMock: [ProfileChartData] = {
        [.init(name: "Work", amount: 3), .init(name: "Relationships", amount: 12),
            .init(name: "Finance", amount: 18), .init(name: "Health", amount: 5)]
    }()

    static var effectivnesMock: [ProfileChartData] = {
        [.init(name: "01.09", amount: 3), .init(name: "01.10", amount: 5),
            .init(name: "01.11", amount: 11), .init(name: "01.12", amount: 8),
            .init(name: "01.01", amount: 9), .init(name: "01.02", amount: 13),
             .init(name: "01.03", amount: 17), .init(name: "01.03", amount: 17)]
    }()
}

// MARK: - State
extension Profile {
    struct State: Equatable {
        var fullName: String
        var moodData: [ProfileChartData]
        var stressData: [ProfileChartData]
        var effectivnesData: [ProfileChartData]

        init() {
            self.fullName = "Happy Doggy"
            self.moodData = ProfileChartData.moodMock
            self.stressData = ProfileChartData.stressMock
            self.effectivnesData = ProfileChartData.effectivnesMock
        }
    }
}

// MARK: - Action
extension Profile {
    enum Action: Equatable {

    }
}

