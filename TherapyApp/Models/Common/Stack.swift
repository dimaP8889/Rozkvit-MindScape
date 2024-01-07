//
//  Stack.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 05.01.2024.
//

import Foundation

public struct Stack<Element: Equatable>: Equatable {
    private var storage: [Element] = []

    init(_ elements: [Element]) {
        storage = elements
    }

    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }

    public func peek() -> Element? {
        storage.last
    }

    public var isEmpty: Bool {
        peek() == nil
    }
}
