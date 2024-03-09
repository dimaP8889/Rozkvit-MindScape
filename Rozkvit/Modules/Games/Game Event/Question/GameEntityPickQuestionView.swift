//
//  GameEntityQuestion.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 13.01.2024.
//

import SwiftUI

struct GameEntityPickQuestionView: View {
    let data: GamePickQuestion

    var body: some View {
        VStack(spacing: 24) {
            titleView
            subtitleView
        }
    }
}

// MARK: - Elements
extension GameEntityPickQuestionView {
    var titleView: some View {
        Text(data.title)
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.mainText)
            .frame(width: 285)
    }

    var subtitleView: some View {
        Text(data.subtitle)
            .font(.main(size: 40, weight: .bold))
            .lineLimit(2)
            .foregroundStyle(.mainText)
    }
}

#Preview {
    VStack {
        GameEntityPickQuestionView(
            data: .init(
                title: "Pick the emotion",
                subtitle: "FEAR"
            )
        )
    }
}
