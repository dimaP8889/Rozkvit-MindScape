//
//  CategoriesView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI
import Charts

struct CategoriesView: View {
    let store: StoreOf<Categories>
    @ObservedObject var viewStore: ViewStore<Categories.State, Categories.Action>

    init(store: StoreOf<Categories>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    var body: some View {
        ZStack {
            background
            foreground
        }
    }
}

// MARK: - Private. Elements
private extension CategoriesView {
    var background: some View {
        Image("categories_bg")
            .resizable()
    }

    var foreground: some View {
        VStack {
            chart
            description
        }
    }

    var chart: some View {
        Chart(viewStore.charts, id: \.name.localization) { data in
            SectorMark(
                angle: .value(Text(data.name.localization), data.amount),
                angularInset: 1
            )
            .foregroundStyle(
                by: .value(
                    Text(verbatim: data.name.localization),
                    data.name.localization
                )
            )
            .annotation(position: .overlay) {
                Text(data.name.localization)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
        .frame(height: 500)
        .padding(.horizontal, 16)
        .chartLegend(.hidden)
    }

    var description: some View {
        Text(localStr("statistic.description"))
            .font(.system(size: 28))
            .fontWeight(.bold)
            .foregroundColor(Color.white)
            .padding(.horizontal, 35)
            .padding(.bottom, 55)
            .multilineTextAlignment(.center)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            store: Store(initialState: Categories.State()) {
                Categories()
            } withDependencies: {
                $0.statistics = .mock
            }
        )
    }
}
