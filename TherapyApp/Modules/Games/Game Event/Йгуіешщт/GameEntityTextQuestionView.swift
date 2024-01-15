//
//  GameEntityTextQuestionView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import SwiftUI

struct GameEntityTextQuestionView: View {
    let data: GameTextQuestion

    var body: some View {
        ZStack {
            questionImageView
            questionTextView
        }
    }
}

// MARK: - Elements
private extension GameEntityTextQuestionView {
    var questionTextView: some View {
        Text(data.title)
            .multilineTextAlignment(.center)
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.mainText)
            .frame(width: 285)
    }

    var questionImageView: some View {
        Image(.question)
    }
}

#Preview {
    GameEntityTextQuestionView(
        data: .init(
            title: "What should you do if you have a panic attack?"
        )
    )
}
