//
//  Localization.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import Foundation

// MARK: - Localization
func localStr(_ key: String) -> String {
    let tableName = Defaults.shared.getCurrentLang()
    return NSLocalizedString(key, tableName: tableName, bundle: .main, value: "", comment: "")
}
