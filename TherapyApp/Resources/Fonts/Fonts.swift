//
//  Fonts.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 14.01.2024.
//

import SwiftUI
import UIKit

extension Font {
    static func main(size: CGFloat, weight: FontWeight = .regular) -> Font {
        Font.custom("Inter-\(weight.name)", size: size)
    }

    enum FontWeight {
        case regular
        case bold
        case semibold

        var name: String {
            switch self {
            case .regular:  return "Regular"
            case .bold:     return "Bold"
            case .semibold: return "SemiBold"
            }
        }
    }
}
