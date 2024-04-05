//
//  CategoriesView.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import WrappingHStack
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
        mainView
            .background(PearlGradient(), ignoresSafeAreaEdges: .top)
    }
}

// MARK: - Private. Elements
private extension CategoriesView {
    var mainView: some View {
        VStack {
            titleView
            Spacer()
            namesListView
            Spacer()
            chartView
            Spacer()
            descriptionView
        }
    }

    var titleView: some View {
        Text(localStr("tab.categories").lowercased())
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.mainText)
    }

    var namesListView: some View {
        WrappingHStack(
            viewStore.charts,
            alignment: .center,
            spacing: .constant(10),
            lineSpacing: 15
        ) { item in
            Text(item.name.capitalized)
                .font(.main(size: 17, weight: .bold))
                .foregroundStyle(item.type.fontColor)
                .padding(.horizontal, 13)
                .frame(height: 40)
                .background(item.type.mainColor)
                .cornerRadius(30)
                .onTapGesture {
                    store.send(.showGamesFor(item.type))
                }
        }
    }

    var chartView: some View {
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
                Text(data.percentage)
                    .font(.main(size: 30, weight: .bold))
                    .foregroundStyle(data.type.fontColor)
            }
        }
        .frame(minHeight: 200, idealHeight: 400)
        .padding(.horizontal, 16)
        .chartLegend(.hidden)
        .chartAngleSelection(value: selectedAngle)
        .chartForegroundStyleScale(range: graphColors(for: viewStore.charts))
    }

    var descriptionView: some View {
        Text(localStr("categories.description"))
            .font(.main(size: 17, weight: .bold))
            .foregroundColor(.mainText)
            .padding(.horizontal, 35)
            .padding(.bottom, 48)
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

// MARK: - Private
private extension CategoriesView {
    func graphColors(for input: [Categories.ChartsData]) -> [Color] {
        var returnColors = [Color]()
        for item in input {
            returnColors.append(item.color)
        }
        return returnColors
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            store: Store(initialState: Categories.State()) {
                Categories()
            } withDependencies: {
                $0.appData = AppDataClientKey.liveValue
            }
        )
    }
}
