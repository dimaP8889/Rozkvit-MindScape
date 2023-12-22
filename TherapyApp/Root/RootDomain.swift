//
//  RootDomain.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootDomain {
    struct State: Equatable {
        var selectedTab = Tab.home

        var categoriesState = Categories.State()
        var homeState = Home.State()
        var gamesState = Games.State()
        var profileState = Profile.State()
    }
    
    enum Tab {
        case categories
        case home
        case games
        case profile
    }

    enum Action: Equatable {
        case tabSelected(Tab)

        case categories(Categories.Action)
        case home(Home.Action)
        case games(Games.Action)
        case profile(Profile.Action)
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.categoriesState, action: \.categories) {
            Categories()
        }

        Reduce { state, action in
            return .none
        }
    }
}
