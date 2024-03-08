//
//  OnFirstAppear.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 08.03.2024.
//

import SwiftUI

public extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View {
        modifier(ViewFirstAppearModifier(perform: action))
    }
}

struct ViewFirstAppearModifier: ViewModifier {
    @State private var didAppearBefore = false
    private let action: () -> Void

    init(perform action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didAppearBefore == false {
                didAppearBefore = true
                action()
            }
        }
    }
}
