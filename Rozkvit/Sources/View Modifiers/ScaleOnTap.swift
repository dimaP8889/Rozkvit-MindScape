//
//  ScaleOnTap.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 26.12.2023.
//
import SwiftUI

public struct ScaleOnTap: ViewModifier {
    @State private var isTapped = false
    private var scaleFactor: ScaleFactor
    private var isHaptickNeeded: Bool

    public init(scaleFactor: ScaleFactor = .min, isHaptick: Bool = false) {
        self.scaleFactor = scaleFactor
        self.isHaptickNeeded = isHaptick
    }

    public func body(content: Content) -> some View {
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.isTapped {
                        self.isTapped = true
                    }
                }
                .onEnded { _ in
                    if isHaptickNeeded {
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                    }
                    self.isTapped = false
                }
            )
            .scaleEffect(isTapped ? scaleFactor.rawValue : 1)
    }
}

extension ScaleOnTap {
    public enum ScaleFactor : Double {
        case min = 0.99
        case max = 0.95
    }
}

public extension View {
    func scaleOnTap(scaleFactor: ScaleOnTap.ScaleFactor = .max, isHaptick: Bool = false) -> some View {
        self.modifier(ScaleOnTap(scaleFactor: scaleFactor, isHaptick: isHaptick))
    }
}
