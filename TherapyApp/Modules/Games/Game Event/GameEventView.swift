//
//  GameEventView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 06.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct GameEventView: View {
    let store: StoreOf<GameEvent>
    @ObservedObject var viewStore: ViewStore<GameEvent.State, GameEvent.Action>
    private var colums: [GridItem]

    init(store: StoreOf<GameEvent>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
        let item = GridItem(.fixed(125), spacing: 25)
        self.colums = [item, item]
    }

    var body: some View {
        VStack {
            navigationView
            main
        }
        .background(Color.peach)
    }
}

// MARK: - Element
private extension GameEventView {
    var main: some View {
        Group {
            if viewStore.core.isFinished {
                resultView
            } else {
                gameView
            }
        }
    }
}

// MARK: - Close
private extension GameEventView {
    var navigationView: some View {
        HStack() {
            close
            Spacer()
            if !viewStore.core.isFinished {
                pagesView
            }
        }
        .padding(.horizontal, 16)
    }

    var close: some View {
        Button(
            action: {
                viewStore.send(.didPressClose)
            },
            label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            }
        )
    }

    var pagesView: some View {
        Text(viewStore.ui.currentPageText)
            .font(.system(size: 18, weight: .medium, design: .monospaced))
    }
}

// MARK: - Result
private extension GameEventView {
    var resultView: some View {
        VStack {
            Spacer()
            resultText
            Spacer()
            button(type: .finish) {
                viewStore.send(.didPressFinish)
            }
        }
    }

    var resultText: some View {
        Text(localStr("game.result.text") + viewStore.ui.resultString)
            .font(.system(size: 25, weight: .bold, design: .monospaced))
    }
}

// MARK: - Game
private extension GameEventView {
    var gameView: some View {
        VStack {
            Spacer()
            gameQuestion
            Spacer()
            answers
            button(type: .continue) {
                viewStore.send(.didPressContinue)
            }
        }
    }

    var gameQuestion: some View {
        Text(viewStore.core.game.question)
            .font(.system(size: 25, weight: .bold, design: .monospaced))
            .padding(.top, 16)
    }

    @ViewBuilder
    var answers: some View {
        if let slide = viewStore.core.currentSlide {
            LazyVGrid(columns: colums, alignment: .center, spacing: 25) {
                ForEach(slide.answers) { answerData in
                    GameEntityAnswerView(
                        answerData: answerData,
                        isSelected: viewStore.core.currentSelectedAnswer == answerData
                    ) { answer in
                        viewStore.send(.didSelectAnswer(answer))
                    }
                }
            }
            .padding(.bottom, 25)
        }
    }
}

// MARK: - Common
private extension GameEventView {
    func button(type: ButtonType, completion: @escaping () -> ()) -> some View {
        Text(type.title)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .font(.system(size: 25, weight: .bold, design: .monospaced))
            .foregroundColor(.black)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .circular
                )
                .fill(Color.white)
                .strokeBorder(Color.black, lineWidth: 1)
            )
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            .onTapGesture {
                completion()
            }
            .scaleOnTap(scaleFactor: .min, isHaptick: true)
    }
}

// MARK: - Model
private extension GameEventView {
    enum ButtonType {
        case `continue`
        case finish

        var title: String {
            switch self {
            case .continue: return localStr("game.button.continue")
            case .finish:   return localStr("game.button.finish")
            }
        }
    }
}

struct GameEventView_Previews: PreviewProvider {
    static var previews: some View {
        let sliders: [GameSlide] = {
            [
                .init(
                    answers: [
                        .init(id: UUID(), image: UIImage(named: "anger_1")!, isCorrect: true),
                        .init(id: UUID(), image: UIImage(named: "fear_1")!, isCorrect: false),
                        .init(id: UUID(), image: UIImage(named: "happiness_1")!, isCorrect: false),
                        .init(id: UUID(), image: UIImage(named: "sadness_1")!, isCorrect: false)
                    ]
                ),

                    .init(
                        answers: [
                            .init(id: UUID(), image: UIImage(named: "anger_2")!, isCorrect: true),
                            .init(id: UUID(), image: UIImage(named: "fear_2")!, isCorrect: false),
                            .init(id: UUID(), image: UIImage(named: "happiness_2")!, isCorrect: false),
                            .init(id: UUID(), image: UIImage(named: "sadness_2")!, isCorrect: false)
                        ]
                    ),

                    .init(
                        answers: [
                            .init(id: UUID(), image: UIImage(named: "anger_3")!, isCorrect: true),
                            .init(id: UUID(), image: UIImage(named: "fear_3")!, isCorrect: false),
                            .init(id: UUID(), image: UIImage(named: "happiness_3")!, isCorrect: false),
                            .init(id: UUID(), image: UIImage(named: "sadness_3")!, isCorrect: false)
                        ]
                    ),

                    .init(
                        answers: [
                            .init(id: UUID(), image: UIImage(named: "anger_4")!, isCorrect: true),
                            .init(id: UUID(), image: UIImage(named: "fear_4")!, isCorrect: false),
                            .init(id: UUID(), image: UIImage(named: "happiness_4")!, isCorrect: false),
                            .init(id: UUID(), image: UIImage(named: "sadness_4")!, isCorrect: false)
                        ]
                    )
            ]
        }()
        let game = GameEnvironment(gameType: .pickEmotion, question: "Pick anger emotion", sliders: sliders)
        GameEventView(
            store: .init(
                initialState: .init(game: game),
                reducer: { GameEvent()._printChanges() }
            )
        )
    }
}
