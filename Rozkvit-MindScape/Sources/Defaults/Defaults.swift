//
//  Defaults.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 17.12.2023.
//

import Foundation

public final class Defaults {

    public static let shared = Defaults()
    private init() {}

    public let preferences = UserDefaults(suiteName: "Project defaults")!

    public func apply() {
        preferences.synchronize()
    }

    public func reset() {
        let dictionary = preferences.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            preferences.removeObject(forKey: key)
        }
    }
}
