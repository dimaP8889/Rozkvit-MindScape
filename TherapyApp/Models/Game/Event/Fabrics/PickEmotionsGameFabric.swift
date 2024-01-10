//
//  PickEmotionsGameFabric.swift
//  TherapyApp
//
//  Created by Dmytro Pogrebniak on 08.01.2024.
//

import SwiftUI
import ComposableArchitecture

final class PickEmotionsGameFabric {
    @Dependency(\.uuid) var uuid

    func createGame() -> GameEnvironment {
        let slides = createSlides()
        return GameEnvironment(gameType: .pickEmotion, sliders: slides)
    }
}

// MARK: - Private
private extension PickEmotionsGameFabric {
    private func createSlides() -> [GameSlide] {
        var slides = [GameSlide]()
        while slides.count != 10 {
            let randomEmotion = Emotion.allCases.randomElement()!
            let answers = createAnswers(for: randomEmotion)
            let slide = GameSlide(question: randomEmotion.question, answers: answers)
            slides.append(slide)
        }
        return slides
    }

    private func createAnswers(for emotion: Emotion) -> [GameAnswer] {
        let correctAnswer = GameAnswer(id: uuid(), image: emotion.randomImage, isCorrect: true)

        var wrongAnswers: [GameAnswer] = []
        while wrongAnswers.count != 3 {
            let image = randomEmotionImage(from: emotion.allEmotionsExceptCurrent, currentAnswers: wrongAnswers)
            let answer = GameAnswer(id: uuid(), image: image, isCorrect: false)
            wrongAnswers.append(answer)
        }
        
        var allAnswers = wrongAnswers
        allAnswers.append(correctAnswer)
        return allAnswers.shuffled()
    }

    func randomEmotionImage(from emotions: [Emotion], currentAnswers: [GameAnswer]) -> Image {
        var images: [Image] = []
        for emotion in emotions {
            switch emotion {
            case .fear:         images += Images.fear
            case .sadness:      images += Images.sadness
            case .surprise:     images += Images.surprise
            case .happiness:    images += Images.happiness
            case .anger:        images += Images.anger
            }
        }

        let currentImages = currentAnswers.map { $0.image }
        var image = images.randomElement()!
        while currentImages.contains(image) {
            image = images.randomElement()!
        }
        return image
    }
}

// MARK: - Model
private extension PickEmotionsGameFabric {
    enum Emotion: CaseIterable {
        case fear
        case sadness
        case surprise
        case happiness
        case anger

        var title: String {
            switch self {
            case .fear:         return "fear"
            case .sadness:      return "sadness"
            case .surprise:     return "surprise"
            case .happiness:    return "happiness"
            case .anger:        return "anger"
            }
        }

        var question: String {
            switch self {
            case .fear:         return localStr("game.emotion.fear.question")
            case .sadness:      return localStr("game.emotion.sadness.question")
            case .surprise:     return localStr("game.emotion.surprise.question")
            case .happiness:    return localStr("game.emotion.happiness.question")
            case .anger:        return localStr("game.emotion.anger.question")
            }
        }

        var randomImage: Image {
            switch self {
            case .fear:         return Images.fear.randomElement()!
            case .sadness:      return Images.sadness.randomElement()!
            case .surprise:     return Images.surprise.randomElement()!
            case .happiness:    return Images.happiness.randomElement()!
            case .anger:        return Images.anger.randomElement()!
            }
        }

        var allEmotionsExceptCurrent: [Emotion] {
            var allEmotions = Emotion.allCases
            allEmotions.removeAll { $0 == self }
            return allEmotions.shuffled()
        }
    }

    struct Images {
        static var anger: [Image] = [Image("anger_1"), Image("anger_2"), Image("anger_3"), Image("anger_4")]
        static var fear: [Image] = [Image("fear_1"), Image("fear_2"), Image("fear_3"), Image("fear_4")]
        static var sadness: [Image] = [Image("sadness_1"), Image("sadness_2"), Image("sadness_3"), Image("sadness_4")]
        static var surprise: [Image] = [Image("surprise_1"), Image("surprise_2"), Image("surprise_3"), Image("surprise_4")]
        static var happiness: [Image] = [Image("happiness_1"), Image("happiness_2"), Image("happiness_3"), Image("happiness_4")]
    }
}


