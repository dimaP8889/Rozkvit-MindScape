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
        main
            .background(backgroundImage)
    }
}

// MARK: - Private. Elements
private extension CategoriesView {
    var backgroundImage: some View {
        Image(.categoriesBg)
            .resizable()
    }

    var main: some View {
        VStack {
            chart
            Spacer()
            description
        }
    }

    var chart: some View {
        Chart(viewStore.charts, id: \.type.localization) { data in
            SectorMark(
                angle: .value(Text(data.name), data.amount),
                angularInset: 1
            )
            .foregroundStyle(
                by: .value(
                    Text(verbatim: data.name),
                    data.name
                )
            )
            .annotation(position: .overlay) {
                Text(data.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
        .frame(height: 500)
        .padding(.horizontal, 16)
        .chartLegend(.hidden)
        .chartAngleSelection(value: selectedAngle)
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

// MARK: - Binding Value
extension CategoriesView {
    var selectedAngle: Binding<Double?> {
        .init(
            get: { viewStore.selectedAngle },
            set: { viewStore.send(.didSelectChart(angle: $0)) }
        )
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            store: Store(initialState: Categories.State()) {
                Categories()
            } withDependencies: {
                $0.appData = .mock
            }
        )
    }
}
