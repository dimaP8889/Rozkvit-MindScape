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

    init(store: StoreOf<GameEvent>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    var body: some View {
        ZStack {
            mainView
            wrongDescriptionView
        }
    }
}

// MARK: - Element
private extension GameEventView {
    var mainView: some View {
        VStack(spacing: 0) {
            navigationView
            headerView
            slideView
        }
        .background(PearlGradient())
        .blur(radius: viewStore.blur)
    }

    var wrongDescriptionView: some View {
        IfLetStore(
            store.scope(state: \.wrongAnswerDescription, action: \.wrongAnswerDescription)
        ) { store in
            GameEntityWrongAnswerDescriptionView(store: store)
        }
    }

    var slideView: some View {
        Group {
            if viewStore.isFinished {
                resultView
            } else {
                gameView
            }
        }
    }

    var headerView: some View {
        VStack {
            categoryText
            categoryNameText
        }
        .padding(.top, 32)
    }

    var categoryText: some View {
        Text(localStr("game.category.title"))
            .font(.main(size: 17, weight: .bold))
            .foregroundStyle(.burnishedBrown)
    }

    var categoryNameText: some View {
        Text(viewStore.game.categoryName)
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.pearlC)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.burnishedBrown)
            )
    }
}

// MARK: - Close
private extension GameEventView {
    var navigationView: some View {
        HStack() {
            Spacer()
            close
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
        Text(viewStore.result)
            .font(.main(size: 25, weight: .bold))
    }
}

// MARK: - Game
private extension GameEventView {
    var gameView: some View {
        VStack(spacing: 0) {
            Spacer()
            gameQuestion
            Spacer()
            answers
            pagesView
            button(type: .continue) {
                viewStore.send(.didPressContinue)
            }
        }
    }

    @ViewBuilder
    var gameQuestion: some View {
        if let question = viewStore.question {
            GameEntityQuestionSectionView(data: question)
        }
    }

    var answers: some View {
        IfLetStore(
            store.scope(state: \.answers, action: \.answers)
        ) { store in
            GameEntityAnswerSectionView(store: store)
        }
        .padding(.bottom, 16)
    }

    var pagesView: some View {
        Text(viewStore.currentPageText)
            .font(.main(size: 17, weight: .bold))
            .foregroundStyle(.mainText)
            .padding(.bottom, 32)
    }
}

// MARK: - Common
private extension GameEventView {
    func button(type: ButtonType, completion: @escaping () -> ()) -> some View {
        Text(type.title)
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 70)
            .font(.main(size: 24, weight: .bold))
            .foregroundColor(.black)
            .background(
                RoundedRectangle(
                    cornerRadius: 30,
                    style: .circular
                )
                .fill(viewStore.answers?.currentSelectedAnswer == nil ? Color.white : Color.melon)
            )
            .padding(.bottom, 16)
            .padding(.horizontal, 36)
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
        let game = GameBuilder().createGame(for: .pickEmotion)
        GameEventView(
            store: .init(
                initialState: .init(game: game),
                reducer: { GameEvent()._printChanges() }
            )
        )
    }
}
