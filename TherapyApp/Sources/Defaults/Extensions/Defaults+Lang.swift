//
//  Defaults+Extensions.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import Foundation

// MARK: - Lang
extension Defaults {
    var defaultLang: String {
        let preferredLanguage = Locale.preferredLanguages[0] as String
        let arr = preferredLanguage.components(separatedBy: "-")
        guard let deviceLanguage = arr.first else {
            return "en"
        }

        switch deviceLanguage {
        default:
            return "en"
        }
    }

    var currentLangFull: String {
        switch getCurrentLang() {
        default:
            return "English"
        }
    }

    private var currentLangKey: String {
        return "current_lang"
    }

    func getCurrentLang() -> String {
        return preferences.string(forKey: currentLangKey) ?? defaultLang
    }

    func setCurrentLang(_ code: String) {
        preferences.set(code, forKey: currentLangKey)
        apply()
    }
}
