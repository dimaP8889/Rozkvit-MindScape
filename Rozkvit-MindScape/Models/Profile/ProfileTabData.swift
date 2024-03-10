//
//  ProfileTabData.swift
//  Rozkvit-MindScape
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

    func effectivenessChartByDay() -> [ProfileChartData] {
        let lastSevenDays = Date().lastSevenDays()

        // Dictionary of results per each day
        var results: [Int: [Int]] = [:]
        for day in lastSevenDays {
            for statistic in databaseStatistic {
                let date = Date(timeIntervalSince1970: TimeInterval(statistic.date))
                let startOfDay = Int(Calendar.current.startOfDay(for: date).timeIntervalSince1970)
                if startOfDay == day {
                    if results[startOfDay] != nil {
                        results[startOfDay]!.append(statistic.result)
                    } else {
                        results[startOfDay] = [statistic.result]
                    }
                }
            }
            if results[day] == nil {
                results[day] = [0]
            }
        }
        return results
            .map { (day: Int, result: [Int]) -> (date: Date, amount: Int) in
                let date = Date(timeIntervalSince1970: TimeInterval(day))
                let amount = result.count == 0 ? 0 : result.reduce(0, +) / result.count
                return (date, amount)
            }
            .sorted {
                $0.date < $1.date
            }
            .map { (date, amount) in
                return ProfileChartData(name: date.formattedDate(by: .therapyEffectivnessByDay), amount: amount)
            }
    }

    private func allTimeCorrectData(for statistic: [DatabaseGameStatistic]) -> [ProfileChartData] {
        if statistic.isEmpty {
            return [
                .init(name: localStr("profile.noData"), amount: 1, color: .gray)
            ]
        }

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

private extension Date {
    func lastSevenDays() -> [Int] {
        let calendar = Calendar.current
        var lastSevenDays: [Int] = []

        for day in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -day, to: self) {
                let startOfDay = calendar.startOfDay(for: date)
                lastSevenDays.append(Int(startOfDay.timeIntervalSince1970))
            }
        }
        return lastSevenDays
    }
}
