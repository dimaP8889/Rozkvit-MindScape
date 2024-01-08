//
//  GameEntityAnswerView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 06.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct GameEntityAnswerView: View {
    var answerData: GameAnswer
    var isSelected: Bool
    var selectAction: (GameAnswer) -> ()

    var body: some View {
        image
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
                .foregroundStyle(isSelected ? Color.green : Color.black)
            )
            .onTapGesture {
                selectAction(answerData)
            }
            .scaleOnTap(scaleFactor: .min, isHaptick: true)
    }
}

// MARK: - Private. Elements
private extension GameEntityAnswerView {
    var image: some View {
        answerData.image
            .resizable()
            .padding(.all, 25)
            .frame(width: 125, height: 125)
    }
}

struct GameEntityAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        let answer = GameAnswer(id: UUID(), image: Image("happiness_1"), isCorrect: true)
        GameEntityAnswerView(answerData: answer, isSelected: false, selectAction: { _ in })
            .frame(width: 200, height: 200)
    }
}
