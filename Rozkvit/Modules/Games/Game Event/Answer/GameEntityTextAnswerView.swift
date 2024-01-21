//
//  GameEntityAnswerView.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 06.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct GameEntityTextAnswerView: View {
    var answerData: GameAnswer<String>
    var isSelected: Bool
    var selectAction: (GameAnswerMetadata) -> ()

    var body: some View {
        textView
            .scaleOnTap(scaleFactor: .min, isHaptick: true)
    }
}

// MARK: - Private. Elements
private extension GameEntityTextAnswerView {
    var textView: some View {
        Text(answerData.value)
            .foregroundStyle(Color.mainText)
            .font(.main(size: 17))
            .frame(maxWidth: .infinity, maxHeight: 32)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(isSelected ? Color.melonB : Color.clear)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.mainText, lineWidth: 1)
                    .expandTap {
                        selectAction(answerData.metadata)
                    }
            }
    }
}

struct GameEntityAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        GameEntityTextAnswerView(
            answerData: .init(metadata: .init(id: UUID(), isCorrect: true), value: "Calm down"),
            isSelected: true,
            selectAction: { _ in })
    }
}
