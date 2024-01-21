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
            .background(backgroundImage)
    }
}

// MARK: - Private. Elements
private extension ProfileView {
    var main: some View {
        VStack(spacing: 16) {
            profileImage
            fullName
            progressSection
            Spacer()
        }
    }

    var backgroundImage: some View {
        Image(.categoriesBg)
            .resizable()
    }

    var profileImage: some View {
        Image(.doggy)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    var fullName: some View {
        Text(viewStore.fullName)
            .font(.system(size: 18))
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
            .font(.system(size: 25, weight: .bold, design: .monospaced))
    }
}

// MARK: - Charts
extension ProfileView {
    var charts: some View {
        VStack {
            HStack {
                moodChart
                stressChart
            }
            effectivnesChart
        }
    }

    var moodChart: some View {
        GroupBox ("Mood") {
            Chart(viewStore.moodData, id: \.name) { data in
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
        }
        .padding(.leading, 16)
        .frame(height: 250)
    }

    var stressChart: some View {
        GroupBox ("Stress Triggers") {
            Chart(viewStore.stressData, id: \.name) { data in
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
        }
        .frame(height: 250)
        .padding(.trailing, 16)
    }

    var effectivnesChart: some View {
        GroupBox ("Therapy Effectivnes") {
            Chart {
                ForEach(viewStore.effectivnesData, id: \.name) { data in
                    LineMark(
                        x: .value("Day", data.name),
                        y: .value("Progress", data.amount)
                    )
                    .interpolationMethod(.catmullRom)
                    .symbol {
                        Circle()
                            .fill(.green)
                            .frame(width: 10)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}


// MARK: - Private. Actions
private extension ProfileView {
    
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
