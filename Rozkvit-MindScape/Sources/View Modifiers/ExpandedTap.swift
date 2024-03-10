//
//  ExpandedTap.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import SwiftUI

private struct ExpandAreaTap: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.clear)
                .contentShape(Rectangle())
            content
        }
    }
}

extension View {
    func expandTap(tap: @escaping () -> ()) -> some View {
        self.modifier(ExpandAreaTap()).onTapGesture(perform: tap)
    }
}
