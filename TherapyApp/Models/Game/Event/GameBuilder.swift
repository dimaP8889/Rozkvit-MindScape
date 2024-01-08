//
//  GameBuilder.swift
//  TherapyApp
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
    let type: GameType
    private var slides: Stack<GameSlide>
    private var results: [Bool] = []
    let amountOfSlides: Int

    static func == (lhs: GameEnvironment, rhs: GameEnvironment) -> Bool {
        lhs.slides == rhs.slides && lhs.results == rhs.results && lhs.amountOfSlides == rhs.amountOfSlides
    }

    init(gameType: GameType, sliders: [GameSlide]) {
        self.type = gameType
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
    let question: String
    var answers: [GameAnswer]
}

struct GameAnswer: Equatable, Identifiable {
    var id: UUID
    var image: Image
    var isCorrect: Bool
}
