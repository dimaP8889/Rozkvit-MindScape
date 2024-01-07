//
//  GameBuilder.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 05.01.2024.
//

import UIKit

final class GameBuilder {
    private var gameStatistic: [GameType: Int]

    init(gameStatistic: [GameType : Int]) {
        self.gameStatistic = gameStatistic
    }

    func createGame(for type: GameType) -> GameEnvironment {
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
        return game
    }
}

final class GameEnvironment: Equatable {
    let type: GameType
    let question: String
    private var slides: Stack<GameSlide>
    private var results: [Bool] = []
    let amountOfSlides: Int

    static func == (lhs: GameEnvironment, rhs: GameEnvironment) -> Bool {
        lhs.question == rhs.question && lhs.slides == rhs.slides && lhs.results == rhs.results
    }

    init(gameType: GameType, question: String, sliders: [GameSlide]) {
        self.type = gameType
        self.question = question
        self.slides = Stack(sliders)
        self.amountOfSlides = sliders.count
    }

    func nextSlide() -> GameSlide? {
        slides.pop()
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
    var answers: [GameAnswer]
}

struct GameAnswer: Equatable, Identifiable {
    var id: UUID
    var image: UIImage
    var isCorrect: Bool
}
