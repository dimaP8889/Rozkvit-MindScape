//
//  GameEntityQuestionSectionView.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct GameEntityQuestionSectionView: View {
    let data: GameQuestion

    var body: some View {
        questionView
    }
}

// MARK: - Private. Elements
private extension GameEntityQuestionSectionView {
    var questionView: some View {
        Group {
            switch data.data {
            case let .pick(data):
                GameEntityPickQuestionView(data: data)
            case let .image(data):
                GameEntityImageQuestionView(data: data)
            case let .text(data):
                GameEntityTextQuestionView(data: data)
            }
        }
    }
}

#Preview {
    GameEntityQuestionSectionView(
        data: .init(
            data: .text(.init(title: "Hello boss"))
        )
    )
}
