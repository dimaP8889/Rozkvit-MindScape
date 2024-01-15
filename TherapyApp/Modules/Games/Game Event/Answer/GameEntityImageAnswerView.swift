//
//  GameEntityImageAnswerView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 14.01.2024.
//

import SwiftUI

struct GameEntityImageAnswerView: View {
    var answerData: GameAnswer<Image>
    var isSelected: Bool
    var selectAction: (GameAnswerMetadata) -> ()

    var body: some View {
        imageView
            .onTapGesture {
                selectAction(answerData.metadata)
            }
            .scaleOnTap(scaleFactor: .min, isHaptick: true)
    }
}

// MARK: - Private. Elements
private extension GameEntityImageAnswerView {
    var imageView: some View {
        answerData.value
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(.mainText, lineWidth: isSelected ? 8 : 0)
            }
            .frame(width: 135, height: 135)
    }
}

#Preview {
    GameEntityImageAnswerView(
        answerData: .init(metadata: .init(id: UUID(), isCorrect: true), value: Image(.anger1)),
        isSelected: true,
        selectAction: { _ in })
}
