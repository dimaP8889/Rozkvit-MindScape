//
//  GameEntityAnswerSectionView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 14.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct GameEntityAnswerSectionView: View {
    let store: StoreOf<GameEntityAnswerSection>
    @ObservedObject var viewStore: ViewStore<GameEntityAnswerSection.State, GameEntityAnswerSection.Action>
    private var colums: [GridItem]

    init(store: StoreOf<GameEntityAnswerSection>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
        let item = GridItem(.fixed(135), spacing: 14)
        self.colums = [item, item]
    }

    var body: some View {
        switch viewStore.answers.data {
        case let .image(answers):
            imagesGridView(answers)
        case let .text(texts):
            textsStackView(texts)
        }
    }
}

// MARK: - Grid
extension GameEntityAnswerSectionView {
    func imagesGridView(_ answers: [GameAnswer<Image>]) -> some View {
        LazyVGrid(columns: colums, alignment: .center, spacing: 28) {
            ForEach(answers) { answerData in
                GameEntityImageAnswerView(
                    answerData: answerData,
                    isSelected: viewStore.currentSelectedAnswer == answerData.metadata
                ) { answer in
                    viewStore.send(.didSelectAnswer(answer))
                }
            }
        }
    }
}

// MARK: - Stack
extension GameEntityAnswerSectionView {
    func textsStackView(_ texts: [GameAnswer<String>]) -> some View {
        VStack {
            ForEach(texts) { answerData in
                GameEntityTextAnswerView(
                    answerData: answerData,
                    isSelected: viewStore.currentSelectedAnswer == answerData.metadata
                ) { answer in
                    viewStore.send(.didSelectAnswer(answer))
                }
            }
        }
        .frame(width: 300)
    }
}

struct GameEntityAnswerSectionView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameBuilder().createGame(for: .pickEmotion)
        GameEntityAnswerSectionView(
            store: .init(
                initialState: .init(answers: game.nextSlide()!.answers),
                reducer: { GameEntityAnswerSection()._printChanges() }
            )
        )
    }
}
