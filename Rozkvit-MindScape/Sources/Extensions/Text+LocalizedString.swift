//
//  Text+LocalizedString.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 18.03.2024.
//

import SwiftUI

extension Text {
    init(styledLocalizedString string: LocalizedString) {
        self = string.styledText()
    }
}
