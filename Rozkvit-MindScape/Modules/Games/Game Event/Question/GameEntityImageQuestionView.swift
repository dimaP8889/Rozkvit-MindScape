//
//  GameEntityImageQuestionView.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import SwiftUI

struct GameEntityImageQuestionView: View {
    let data: GameImageQuestion

    var body: some View {
        VStack {
            titleView
            imageView
        }
    }
}

// MARK: - Elements
extension GameEntityImageQuestionView {
    var titleView: some View {
        Text(data.title)
            .multilineTextAlignment(.center)
            .font(.main(size: 24, weight: .bold))
            .foregroundStyle(.mainText)
            .frame(width: 285)
            .frame(minHeight: 75)
    }

    var imageView: some View {
        data.image
            .resizable()
            .frame(width: 300, height: 275)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    GameEntityImageQuestionView(
        data: .init(
            title: "What will you do with this wall?",
            image: Image(.boyAndWall)
        )
    )
}
