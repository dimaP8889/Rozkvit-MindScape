//
//  GameProgressView.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 22.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct GameProgressView: View {
    let game: GameData
    let selectAction: (GameType) -> Void

    var body: some View {
        VStack(spacing: 0) {
            imageView
            gameInfoView
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: .infinity)
        .allowsHitTesting(game.availabilityState == .available)
        .onTapGesture {
            selectAction(game.type)
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Private. Elements
private extension GameProgressView {
    var imageView: some View {
        ZStack {
            game.image
                .resizable()
                .aspectRatio(contentMode: .fill)
            if !game.availabilityState.isGameAvailable {
                notAvailableView
            }
        }
        .frame(maxHeight: 240)
    }

    var notAvailableView: some View {
        ZStack {
            Color.mainText.opacity(0.78)
            Text(game.availabilityState.unavailableText)
                .font(.main(size: 12))
                .foregroundStyle(.greyText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 200)
        }
    }

    var gameInfoView: some View {
        HStack(alignment: .center) {
            gameNameView
            Spacer()
            gameProgressView
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
        .padding(.horizontal, 16)
        .background(.white)
    }

    var gameNameView: some View {
        Text(game.title)
            .font(.main(size: 17, weight: .bold))
            .padding(.top, 3)
    }

    var gameProgressView: some View {
        HStack(spacing: 2) {
            game.progress.firstStar
            game.progress.secondStar
            game.progress.thirdStar
        }
    }
}

struct GameProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GameProgressView(
            game: .init(type: .pickEmotion, progress: 45, availabilityState: .available),
            selectAction: { _ in }
        )
    }
}
