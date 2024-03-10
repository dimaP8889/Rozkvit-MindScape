//
//  PearlGradient.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 14.01.2024.
//

import SwiftUI

struct PearlGradient: ShapeStyle {
    func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        LinearGradient(
            gradient: Gradient(colors: [.pearlA, .pearlB]),
            startPoint: .top,
            endPoint: .bottom)
    }
}
