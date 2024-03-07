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
        return fabric.createGame(of: type)
    }

    func createNextGame(for statistic: [GameType: Int]) -> GameEnvironment {
        let nextGame = nextGame(for: statistic)
        return createGame(for: nextGame)
    }

    private func nextGame(for statistic: [GameType: Int]) -> GameType {
        let availabilityChecker = AvailabilityChecker()

        var prevGame: GameType = .pickEmotion
        for game in GameType.allCases {
            if availabilityChecker.gameAvailability(game, gameStatistic: statistic) != .available {
                return prevGame
            }
            prevGame = game
        }
        return prevGame
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

    func percentOfCorrectAnswers() -> Int {
        let correctAmount = results.filter { $0 == true }.count
        return Int((Double(correctAmount) / Double(results.count)) * 100)
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
        case .fear:             return Image(.fear1)
        case .sadness:          return Image(.sadness1)
        case .surprise:         return Image(.surprise1)
        case .happiness:        return Image(.happiness1)
        case .anger:            return Image(.anger2)

        case .contempt:         return Image(.contempt1)
        case .disgust:          return Image(.disgust2)
        case .excitement:       return Image(.excitement1)
        case .interest:         return Image(.interest4)
        case .relief:           return Image(.relief1)

        case .anticipation:     return Image(.anticipation3)
        case .boredom:          return Image(.boredom3)
        case .confusion:        return Image(.confusion3)
        case .contentment:      return Image(.contentment2)
        case .embarrassment:    return Image(.embarrassment1)

        case .envy:             return Image(.envy1)
        case .guilt:            return Image(.guilt2)
        case .pride:            return Image(.pride3)
        case .shame:            return Image(.shame3)
        }
    }

    var description: String {
        switch self {
        case .fear:             return localStr("game.wrongAnswer.fear.description")
        case .sadness:          return localStr("game.wrongAnswer.sadness.description")
        case .surprise:         return localStr("game.wrongAnswer.surprise.description")
        case .happiness:        return localStr("game.wrongAnswer.happiness.description")
        case .anger:            return localStr("game.wrongAnswer.anger.description")

        case .contempt:         return localStr("game.wrongAnswer.contempt.description")
        case .disgust:          return localStr("game.wrongAnswer.disgust.description")
        case .excitement:       return localStr("game.wrongAnswer.excitement.description")
        case .interest:         return localStr("game.wrongAnswer.interest.description")
        case .relief:           return localStr("game.wrongAnswer.relief.description")

        case .anticipation:     return localStr("game.wrongAnswer.anticipation.description")
        case .boredom:          return localStr("game.wrongAnswer.boredom.description")
        case .confusion:        return localStr("game.wrongAnswer.confusion.description")
        case .contentment:      return localStr("game.wrongAnswer.contentment.description")
        case .embarrassment:    return localStr("game.wrongAnswer.embarrassment.description")

        case .envy:             return localStr("game.wrongAnswer.anticipation.description")
        case .guilt:            return localStr("game.wrongAnswer.boredom.description")
        case .pride:            return localStr("game.wrongAnswer.confusion.description")
        case .shame:            return localStr("game.wrongAnswer.contentment.description")
        }
    }
}
