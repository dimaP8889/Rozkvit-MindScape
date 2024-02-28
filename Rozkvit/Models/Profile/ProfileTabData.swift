//
//  ProfileTabData.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import ComposableArchitecture
import Foundation

final class ProfileTabData {
    private var databaseStatistic: [DatabaseGameStatistic]

    init(databaseStatistic: [DatabaseGameStatistic]) {
        self.databaseStatistic = databaseStatistic
    }

    func todayCorrectData() -> [ProfileChartData] {
        let todaysStat = databaseStatistic.filter { stat in
            let date = Date(timeIntervalSince1970: TimeInterval(stat.date))
            return Calendar.current.isDateInToday(date)
        }
        return allTimeCorrectData(for: todaysStat)
    }

    func allTimeCorrectData() -> [ProfileChartData] {
        allTimeCorrectData(for: databaseStatistic)
    }

    func effectivenessChart() -> [ProfileChartData] {
        let sortedStatistic = databaseStatistic.sorted { $0.date < $1.date }

        return sortedStatistic.map { stat in
            let date = Date(timeIntervalSince1970: TimeInterval(stat.date))
            return ProfileChartData(name: date.formattedDate(), amount: stat.result)
        }
    }

    func effectivenessChartByDay() -> [ProfileChartData] {
        // Count number of results for each day
        var daysDict: [String: Int] = [:]
        databaseStatistic.forEach { data in
            let date = Date(timeIntervalSince1970: TimeInterval(data.date)).formattedDate(by: .therapyEffectivnessByDay)
            if daysDict[date] != nil {
                daysDict[date]! += 1
            } else {
                daysDict[date] = 1
            }
        }

        // Create a dictionary with total result for a day
        var daysResultDict: [String: Int] = [:]
        databaseStatistic.forEach { data in
            let date = Date(timeIntervalSince1970: TimeInterval(data.date)).formattedDate(by: .therapyEffectivnessByDay)
            daysResultDict[date] = (daysResultDict[date] ?? 0) + data.result
        }

        let final = daysResultDict
            .map { day, result in
                ProfileChartData(name: day, amount: result / (daysDict[day] ?? 1))
            }
            .sorted {
                $0.name < $1.name
            }
        return final
    }

    private func allTimeCorrectData(for statistic: [DatabaseGameStatistic]) -> [ProfileChartData] {
        let totalResult = statistic.reduce(0) { partialResult, stat in
            partialResult + stat.result
        }
        let medianCorrect = statistic.count > 0 ? (totalResult / statistic.count) : 0
        let medianIncorrect = 100 - medianCorrect

        return [
            .init(name: localStr("profile.correct"), amount: medianCorrect, color: .pieChart1),
            .init(name: localStr("profile.incorrect"), amount: medianIncorrect, color: .pieChart3)
        ]
    }
}
