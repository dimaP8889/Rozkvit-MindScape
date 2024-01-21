//
//  GameProgressView.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 22.12.2023.
//

import ComposableArchitecture
import SwiftUI

struct GameProgressView: View {
    let game: GameData
    let selectAction: (GameType) -> Void

    var body: some View {
        ZStack(alignment: .center) {
            background
            foreground
        }
        .frame(width: 300)
    }
}

// MARK: - Private. Elements
private extension GameProgressView {
    @ViewBuilder
    var foreground: some View {
        if !game.isAvailable {
            Color.white.opacity(0.7)
        }
    }

    var background: some View {
        VStack(alignment: .leading, spacing: 16) {
            gameName
            progressBar
        }
        .onTapGesture {
            selectAction(game.type)
        }
        .scaleOnTap(scaleFactor: .min)
    }

    var gameName: some View {
        Text(game.type.title)
    }

    var progressBar: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(height: 20)
                .opacity(0.3)
                .foregroundColor(.gray)

            Rectangle()
                .frame(width: CGFloat(game.progress * 3), height: 20)
                .foregroundColor(.green)
                .animation(.easeInOut, value: game.progress)

            Rectangle()
                .frame(width: 2, height: 20)
                .foregroundColor(.red)
                .padding(.leading, 300 * 0.8)
        }
    }
}

struct GameProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GameProgressView(
            game: .init(type: .pickEmotion, progress: 45, isAvailable: true),
            selectAction: { _ in }
        )
    }
}
