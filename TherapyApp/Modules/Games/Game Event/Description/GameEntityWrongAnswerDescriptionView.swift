//
//  WrongAnswerDescriptionView.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 13.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct GameEntityWrongAnswerDescriptionView: View {
    let store: StoreOf<GameEntityWrongAnswerDescription>
    @ObservedObject var viewStore: ViewStore<GameEntityWrongAnswerDescription.State, GameEntityWrongAnswerDescription.Action>

    init(store: StoreOf<GameEntityWrongAnswerDescription>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                contentStack
                    .frame(width: geometry.size.width - 48)
                    .padding(.horizontal, 24)
                Spacer()
            }
        }
    }
}

// MARK: - Elements
extension GameEntityWrongAnswerDescriptionView {
    var contentStack: some View {
        VStack(spacing: 24) {
            titleView
            imageView
            textView
            continueButton
        }
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(PearlGradient())
                .stroke(Color.mainText, lineWidth: 2)
        )
    }

    var titleView: some View {
        VStack {
            titleText
            subtitleText
        }
    }
    
    @ViewBuilder
    var titleText: some View {
        if let title = viewStore.model.title {
            Text(title)
                .font(.main(size: 24, weight: .bold))
                .foregroundStyle(.mainText)
                .padding(.horizontal, 16)
                .padding(.top, 16)
        }
    }

    @ViewBuilder
    var subtitleText: some View {
        if let subtitle = viewStore.model.subtitle {
            Text(subtitle)
                .font(.main(size: 40, weight: .bold))
                .foregroundStyle(.mainText)
                .padding(.horizontal, 16)
        }
    }

    var imageView: some View {
        viewStore.model.image
            .resizable()
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.mainText, lineWidth: 2)
            )
    }

    var textView: some View {
        Text(viewStore.model.description)
            .font(.main(size: 12, weight: .regular))
            .multilineTextAlignment(.leading)
            .foregroundStyle(.mainText)
            .padding(.horizontal, 16)
            .padding(.top, 8)
    }

    var continueButton: some View {
        Button {
            viewStore.send(.didPressContinue)
        } label: {
            Text(localStr("game.button.continue"))
                .foregroundStyle(.mainText)
                .font(.main(size: 24, weight: .bold))
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.white)
        )
        .padding(.bottom, 24)
    }
}

#Preview {
    return GameEntityWrongAnswerDescriptionView(
        store: .init(
            initialState: GameEntityWrongAnswerDescription.State(model: .init(emotion: .anger)),
            reducer: {
                GameEntityWrongAnswerDescription()
            }
        )
    )
}
