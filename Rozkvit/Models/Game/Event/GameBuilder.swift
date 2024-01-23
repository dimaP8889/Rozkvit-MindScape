//
//  GameBuilder.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 05.01.2024.
//

import UIKit
import SwiftUI

final class GameBuilder {
    func createGame(for type: GameType) -> GameEnvironment {
        let fabric = PickEmotionsGameFabric()
        return fabric.createGame()
    }
}

final class GameEnvironment: Equatable {
    private var slides: Stack<GameSlide>
    private var results: [Bool] = []
    
    let type: GameType
    let category: CategoryType
    var currentSlide: GameSlide?
    let amountOfSlides: Int

    static func == (lhs: GameEnvironment, rhs: GameEnvironment) -> Bool {
        lhs.slides == rhs.slides && lhs.results == rhs.results && lhs.amountOfSlides == rhs.amountOfSlides
    }

    init(gameType: GameType, category: CategoryType, sliders: [GameSlide]) {
        self.type = gameType
        self.category = category
        self.slides = Stack(sliders)
        self.amountOfSlides = sliders.count
    }

    func nextSlide() -> GameSlide? {
        currentSlide = slides.pop()
        return currentSlide
    }

    func submit(result: Bool) {
        results.append(result)
    }

    func percentOfCorrectAnswers() -> Double {
        let correctAmount = results.filter { $0 == true }.count
        return Double(correctAmount) / Double(results.count)
    }
}

struct GameSlide: Equatable {
    let question: GameQuestion
    let answers: GameAnswers
    let wrongAnswerDescription: GameWrongAnswerDescription?
}

// MARK: - Question
struct GameQuestion: Equatable {
    let data: DataType

    enum DataType: Equatable {
        case pick(GamePickQuestion)
        case image(GameImageQuestion)
        case text(GameTextQuestion)
    }
}

struct GamePickQuestion: Equatable {
    let title: String
    let subtitle: String
}

struct GameImageQuestion: Equatable {
    let title: String
    let image: Image
}

struct GameTextQuestion: Equatable {
    let title: String
}

// MARK: - Answer
struct GameAnswers: Equatable {
    let data: DataType

    enum DataType: Equatable {
        case text([GameAnswer<String>])
        case image([GameAnswer<Image>])
    }
}

struct GameAnswerMetadata: Equatable {
    var id: UUID
    var isCorrect: Bool
}

struct GameAnswer<T: Equatable>: Equatable, Identifiable {
    var id: UUID { metadata.id }
    var metadata: GameAnswerMetadata
    var value: T
}

// MARK: - Wrong answer description
struct GameWrongAnswerDescription: Equatable {
    var title: String?
    var subtitle: String?
    var image: Image
    var description: String

    init(title: String? = nil, subtitle: String? = nil, image: Image, description: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.description = description
    }

    init(emotion: Emotion) {
        self.title = localStr("game.wrongAnswer.title")
        self.subtitle = emotion.title.uppercased()
        self.image = emotion.mainImage
        self.description = emotion.description
    }
}

private extension Emotion {
    var mainImage: Image {
        switch self {
        case .fear:         return Image(.fear1)
        case .sadness:      return Image(.sadness1)
        case .surprise:     return Image(.surprise1)
        case .happiness:    return Image(.happiness1)
        case .anger:        return Image(.anger2)
        }
    }

    var description: String {
        switch self {
        case .fear:         return localStr("game.wrongAnswer.fear.description")
        case .sadness:      return localStr("game.wrongAnswer.sadness.description")
        case .surprise:     return localStr("game.wrongAnswer.surprise.description")
        case .happiness:    return localStr("game.wrongAnswer.happiness.description")
        case .anger:        return localStr("game.wrongAnswer.anger.description")
        }
    }
}
