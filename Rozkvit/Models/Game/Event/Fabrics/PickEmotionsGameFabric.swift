//
//  PickEmotionsGameFabric.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 08.01.2024.
//

import SwiftUI
import ComposableArchitecture

final class PickEmotionsGameFabric {
    @Dependency(\.uuid) var uuid

    func createGame(of type: GameType) -> GameEnvironment {
        let slides = createSlides()
        let category = CategoryType.allCases.category(for: type) ?? .emotionalIntelect
        return GameEnvironment(
            gameType: type,
            category: category,
            sliders: slides
        )
    }
}

// MARK: - Private
private extension PickEmotionsGameFabric {
    private func createSlides() -> [GameSlide] {
        var slides = [GameSlide]()
        while slides.count != 10 {
            let randomEmotion = Emotion.allCases.randomElement()!
            let answers = createImageAnswers(for: randomEmotion)
            let slide = GameSlide(
                question: randomEmotion.question,
                answers: answers,
                wrongAnswerDescription: .init(emotion: randomEmotion)
            )
            slides.append(slide)
        }

//        while slides.count != 4 {
//            let question = GameQuestion(
//                data: .image(.init(
//                    title: localStr("game.wall.question"),
//                    image: Image(.boyAndWall))
//                ))
//            let answers = createWallTextAnswers()
//            let slide = GameSlide(
//                question: question,
//                answers: answers,
//                wrongAnswerDescription: nil
//            )
//            slides.append(slide)
//        }
//
//        while slides.count != 5 {
//            let question = GameQuestion(data: .text(.init(title: localStr("game.panic.question"))))
//            let answers = createPanicTextAnswers()
//            let slide = GameSlide(
//                question: question,
//                answers: answers,
//                wrongAnswerDescription: .init(image: Image(.calmDown), description: localStr("game.panic.advice"))
//            )
//            slides.append(slide)
//        }

        return slides.shuffled()
    }

    private func createImageAnswers(for emotion: Emotion) -> GameAnswers {
        var answers: [GameAnswer<Image>] = []
        let correctAnswer = GameAnswer<Image>(metadata: .init(id: uuid(), isCorrect: true), value: emotion.randomImage)
        answers.append(correctAnswer)

        while answers.count != 4 {
            let image = randomEmotionImage(from: emotion.allEmotionsExceptCurrent, currentAnswers: answers)
            let answer = GameAnswer<Image>(metadata: .init(id: uuid(), isCorrect: false), value: image)
            answers.append(answer)
        }
        return .init(data: .image(answers.shuffled()))
    }

    private func createWallTextAnswers() -> GameAnswers {
        var answers: [GameAnswer<String>] = []
        while answers.count != 4 {
            let text = localStr("game.wall.answer.\(answers.count + 1)")
            let answer = GameAnswer<String>(metadata: .init(id: uuid(), isCorrect: true), value: text)
            answers.append(answer)
        }
        return .init(data: .text(answers.shuffled()))
    }

    private func createPanicTextAnswers() -> GameAnswers {
        var answers: [GameAnswer<String>] = []
        let correctAnswer = GameAnswer<String>(metadata: .init(id: uuid(), isCorrect: true), value: localStr("game.panic.answer.1"))
        answers.append(correctAnswer)

        while answers.count != 4 {
            let text = localStr("game.panic.answer.\(answers.count + 1)")
            let answer = GameAnswer<String>(metadata: .init(id: uuid(), isCorrect: false), value: text)
            answers.append(answer)
        }
        return .init(data: .text(answers.shuffled()))
    }

    func randomEmotionImage(from emotions: [Emotion], currentAnswers: [GameAnswer<Image>]) -> Image {
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

        let currentImages = currentAnswers
            .map { $0.value }
            .compactMap { $0 }
        var image = images.randomElement()!
        while currentImages.contains(image) {
            image = images.randomElement()!
        }
        return image
    }
}
