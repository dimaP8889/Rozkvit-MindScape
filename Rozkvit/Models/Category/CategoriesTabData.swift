//
//  CategoriesTabData.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 25.02.2024.
//

import Foundation

final class CategoriesTabData {
    var chartsData: [Categories.ChartsData] {
        CategoryType.allCases.map { type in
            Categories.ChartsData(type: type, amount: (1 / Double(CategoryType.allCases.count)))
        }
    }
}
