//
//  ProfileView.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import ComposableArchitecture
import SwiftUI
import Charts

struct ProfileView: View {
    let store: StoreOf<Profile>
    @ObservedObject var viewStore: ViewStore<Profile.State, Profile.Action>

    init(store: StoreOf<Profile>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    var body: some View {
        main
            .background(PearlGradient(), ignoresSafeAreaEdges: .top)
            .onAppear { store.send(.onAppear) }
    }
}

// MARK: - Private. Elements
private extension ProfileView {
    var main: some View {
        VStack(spacing: 0) {
            profileImage
            fullName
            progressSection
        }
    }

    var profileImage: some View {
        Image(.doggy)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    var fullName: some View {
        Text(viewStore.fullName)
            .font(.main(size: 17, weight: .bold))
            .foregroundStyle(.lightCoral)
            .padding(.top, 12)
    }
}

// MARK: - Progress
extension ProfileView {
    var progressSection: some View {
        VStack {
            progressTitle
            charts
        }
    }

    var progressTitle: some View {
        Text(localStr("profile.progress"))
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.mainText)
            .padding(.top, 28)
    }
}

// MARK: - Charts
extension ProfileView {
    var charts: some View {
        VStack {
            HStack {
                todayCorrectChart
                allTimeChart
            }
            effectivenessChart
            Spacer()
        }
        .padding(.top, 16)
    }

    var todayCorrectChart: some View {
        GroupBox(localStr("profile.today.correct")) {
            Chart(viewStore.todayCorrectData, id: \.name) { data in
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
            }
            .chartForegroundStyleScale(range: graphColors(for: viewStore.todayCorrectData))
        }
        .foregroundStyle(.mainText)
        .padding(.leading, 16)
        .frame(minHeight: 150, idealHeight: 250)
    }

    var allTimeChart: some View {
        GroupBox(localStr("profile.alltime.correct")) {
            Chart(viewStore.allTimeCorrectData, id: \.name) { data in
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
            }
            .chartForegroundStyleScale(range: graphColors(for: viewStore.allTimeCorrectData))
        }
        .foregroundStyle(.mainText)
        .frame(minHeight: 150, idealHeight: 250)
        .padding(.trailing, 16)
    }

    var effectivenessChart: some View {
        GroupBox(localStr("profile.alltime.effectiveness")) {
            Chart {
                ForEach(viewStore.effectivenessData, id: \.name) { data in
                    BarMark(
                        x: .value("Day", data.name),
                        y: .value("Progress", data.amount)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(.lineChart)
                }
            }
        }
        .chartYAxis() {
            AxisMarks(
                position: .leading,
                values: [0, 25, 50, 75, 100]
            ) {
                AxisValueLabel(format: Decimal.FormatStyle.Percent.percent.scale(1))
            }
        }
        .foregroundStyle(.mainText)
        .frame(minHeight: 150, idealHeight: 250)
        .padding(.horizontal, 16)
    }
}


// MARK: - Private
private extension ProfileView {
    func graphColors(for input: [ProfileChartData]) -> [Color] {
        var returnColors = [Color]()
        for item in input {
            if let color = item.color {
                returnColors.append(color)
            }
        }
        return returnColors
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(
            store: .init(
                initialState: .init(),
                reducer: { Profile() }
            )
        )
    }
}
