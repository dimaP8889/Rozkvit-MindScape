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
        let slides = createSlides(for: type)
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
    private func createSlides(for game: GameType) -> [GameSlide] {
        guard let levelDesign = GameLevelDesign(game: game) else { return [] }

        if game == .pickEmotion {
            var slides = [GameSlide]()

            while slides.count != levelDesign.firstPhaseAmount {
                let randomEmotion = Emotion.level1.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: true)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }
            return slides.shuffled()
        }

        if game == .pickEmotion2 {
            var slides = [GameSlide]()

            while slides.count != levelDesign.firstPhaseAmount {
                let randomEmotion = Emotion.level2.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: true)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }

            while slides.count != levelDesign.secondPhaseAmount {
                let randomEmotion = Emotion.level1.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: false)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }
            return slides.shuffled()
        }

        if game == .pickEmotion3 {
            var slides = [GameSlide]()
            while slides.count != levelDesign.firstPhaseAmount {
                let randomEmotion = Emotion.level3.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: true)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }

            while slides.count != levelDesign.secondPhaseAmount {
                let randomEmotion = Emotion.level2.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: false)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }

            while slides.count != levelDesign.thirdPhaseAmount {
                let randomEmotion = Emotion.level1.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: false)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }
            return slides.shuffled()
        }

        if game == .pickEmotion4 {
            var slides = [GameSlide]()
            while slides.count != levelDesign.firstPhaseAmount {
                let randomEmotion = Emotion.level4.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: true)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }

            while slides.count != levelDesign.secondPhaseAmount {
                let randomEmotion = Emotion.level3.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: false)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }

            while slides.count != levelDesign.thirdPhaseAmount {
                let randomEmotion = Emotion.level2.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: false)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }

            while slides.count != levelDesign.fourthPhaseAmount {
                let randomEmotion = Emotion.level1.randomElement()!
                let answers = createImageAnswers(for: randomEmotion, isCurrentLevelEmotion: false)
                let slide = GameSlide(
                    question: randomEmotion.question,
                    answers: answers,
                    wrongAnswerDescription: .init(emotion: randomEmotion)
                )
                slides.append(slide)
            }
            return slides.shuffled()
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

        return []
    }

    private func createImageAnswers(for emotion: Emotion, isCurrentLevelEmotion: Bool) -> GameAnswers {
        var answers: [GameAnswer<Image>] = []
        let correctAnswer = GameAnswer<Image>(metadata: .init(id: uuid(), isCorrect: true), value: emotion.randomImage)
        answers.append(correctAnswer)

        while answers.count != 4 {
            let emotions = isCurrentLevelEmotion ? emotion.currentLevelEmotionsExceptCurrent : emotion.allEmotionsExceptCurrent
            let image = randomEmotionImage(from: emotions, currentAnswers: answers)
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

    private func randomEmotionImage(from emotions: [Emotion], currentAnswers: [GameAnswer<Image>]) -> Image {
        var images: [Image] = []
        for emotion in emotions {
            switch emotion {
            case .fear:             images += Images.fear
            case .sadness:          images += Images.sadness
            case .surprise:         images += Images.surprise
            case .happiness:        images += Images.happiness
            case .anger:            images += Images.anger

            case .contempt:         images += Images.contempt
            case .disgust:          images += Images.disgust
            case .excitement:       images += Images.excitement
            case .interest:         images += Images.interest
            case .relief:           images += Images.relief

            case .anticipation:     images += Images.anticipation
            case .boredom:          images += Images.boredom
            case .confusion:        images += Images.confusion
            case .contentment:      images += Images.contentment
            case .embarrassment:    images += Images.embarrassment

            case .envy:             images += Images.envy
            case .guilt:            images += Images.guilt
            case .pride:            images += Images.pride
            case .shame:            images += Images.shame
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

private extension PickEmotionsGameFabric {
    enum GameLevelDesign {
    #if DEBUG
        static var isDebug = true
    #else
        static var isDebug = false
    #endif

        case firstLevel
        case secondLevel
        case thirdLevel
        case fourthLevel

        var firstPhaseAmount: Int {
            return GameLevelDesign.isDebug ? 2 : 10
        }

        var secondPhaseAmount: Int {
            switch self {
            case .firstLevel:   return firstPhaseAmount + 0
            case .secondLevel:  return firstPhaseAmount + (GameLevelDesign.isDebug ? 1 : 4)
            case .thirdLevel:   return firstPhaseAmount + (GameLevelDesign.isDebug ? 1 : 3)
            case .fourthLevel:  return firstPhaseAmount + (GameLevelDesign.isDebug ? 1 : 2)
            }
        }

        var thirdPhaseAmount: Int {
            switch self {
            case .firstLevel:   return secondPhaseAmount + 0
            case .secondLevel:  return secondPhaseAmount + 0
            case .thirdLevel:   return secondPhaseAmount + (GameLevelDesign.isDebug ? 1 : 3)
            case .fourthLevel:  return secondPhaseAmount + (GameLevelDesign.isDebug ? 1 : 2)
            }
        }

        var fourthPhaseAmount: Int {
            switch self {
            case .firstLevel:   return thirdPhaseAmount + 0
            case .secondLevel:  return thirdPhaseAmount + 0
            case .thirdLevel:   return thirdPhaseAmount + 0
            case .fourthLevel:  return thirdPhaseAmount + (GameLevelDesign.isDebug ? 1 : 2)
            }
        }

        init?(game: GameType) {
            switch game {
            case .pickEmotion:  self = .firstLevel
            case .pickEmotion2: self = .secondLevel
            case .pickEmotion3: self = .thirdLevel
            case .pickEmotion4: self = .fourthLevel

            default: return nil
            }
        }
    }
}
