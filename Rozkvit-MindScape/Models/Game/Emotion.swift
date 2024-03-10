//
//  Emotion.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import SwiftUI

enum Emotion: CaseIterable {
    // Level 1
    case fear
    case sadness
    case surprise
    case happiness
    case anger

    // Level 2
    case contempt
    case disgust
    case excitement
    case interest
    case relief

    // Level 3
    case anticipation
    case boredom
    case confusion
    case contentment
    case embarrassment

    // Level 4
    case envy
    case guilt
    case pride
    case shame

    static var level1: [Emotion] = [.fear, .sadness, .surprise, .happiness, .anger]
    static var level2: [Emotion] = [.contempt, .disgust, .excitement, .interest, .relief]
    static var level3: [Emotion] = [.anticipation, .boredom, .confusion, .contentment, .embarrassment]
    static var level4: [Emotion] = [.envy, .guilt, .pride, .shame]

    var title: String {
        switch self {
        case .fear:             return localStr("game.emotion.fear.title")
        case .sadness:          return localStr("game.emotion.sadness.title")
        case .surprise:         return localStr("game.emotion.surprise.title")
        case .happiness:        return localStr("game.emotion.happiness.title")
        case .anger:            return localStr("game.emotion.anger.title")

        case .contempt:         return localStr("game.emotion.contempt.title")
        case .disgust:          return localStr("game.emotion.disgust.title")
        case .excitement:       return localStr("game.emotion.excitement.title")
        case .interest:         return localStr("game.emotion.interest.title")
        case .relief:           return localStr("game.emotion.relief.title")

        case .anticipation:     return localStr("game.emotion.anticipation.title")
        case .boredom:          return localStr("game.emotion.boredom.title")
        case .confusion:        return localStr("game.emotion.confusion.title")
        case .contentment:      return localStr("game.emotion.contentment.title")
        case .embarrassment:    return localStr("game.emotion.embarrassment.title")

        case .envy:             return localStr("game.emotion.envy.title")
        case .guilt:            return localStr("game.emotion.guilt.title")
        case .pride:            return localStr("game.emotion.pride.title")
        case .shame:            return localStr("game.emotion.shame.title")
        }
    }

    var question: GameQuestion {
        let questionData = GamePickQuestion(
            title: localStr("game.emotion.pick.question.title"),
            subtitle: self.title.uppercased()
        )
        return GameQuestion(data: .pick(questionData))
    }

    var randomImage: Image {
        switch self {
        case .fear:             return Images.fear.randomElement()!
        case .sadness:          return Images.sadness.randomElement()!
        case .surprise:         return Images.surprise.randomElement()!
        case .happiness:        return Images.happiness.randomElement()!
        case .anger:            return Images.anger.randomElement()!

        case .contempt:         return Images.contempt.randomElement()!
        case .disgust:          return Images.disgust.randomElement()!
        case .excitement:       return Images.excitement.randomElement()!
        case .interest:         return Images.interest.randomElement()!
        case .relief:           return Images.relief.randomElement()!

        case .anticipation:     return Images.anticipation.randomElement()!
        case .boredom:          return Images.boredom.randomElement()!
        case .confusion:        return Images.confusion.randomElement()!
        case .contentment:      return Images.contentment.randomElement()!
        case .embarrassment:    return Images.embarrassment.randomElement()!

        case .envy:             return Images.envy.randomElement()!
        case .guilt:            return Images.guilt.randomElement()!
        case .pride:            return Images.pride.randomElement()!
        case .shame:            return Images.shame.randomElement()!
        }
    }

    var allEmotionsExceptCurrent: [Emotion] {
        var allEmotions = Emotion.allCases
        allEmotions.removeAll { $0 == self }
        return allEmotions.shuffled()
    }

    var currentLevelEmotionsExceptCurrent: [Emotion] {
        var allEmotions = levelEmotions
        allEmotions.removeAll { $0 == self }
        return allEmotions.shuffled()
    }

    private var levelEmotions: [Emotion] {
        if Emotion.level1.contains(self) {
            return Emotion.level1
        }
        if Emotion.level2.contains(self) {
            return Emotion.level2
        }
        if Emotion.level3.contains(self) {
            return Emotion.level3
        }
        if Emotion.level4.contains(self) {
            return Emotion.level4
        }
        return Emotion.allCases
    }
}

struct Images {
    // Level 1
    static var anger: [Image] = [Image(.anger1), Image(.anger2), Image(.anger3), Image(.anger4)]
    static var fear: [Image] = [Image(.fear1), Image(.fear2), Image(.fear3), Image(.fear4)]
    static var sadness: [Image] = [Image(.sadness1), Image(.sadness2), Image(.sadness3), Image(.sadness4)]
    static var surprise: [Image] = [Image(.surprise1), Image(.surprise2), Image(.surprise3), Image(.surprise4)]
    static var happiness: [Image] = [Image(.happiness1), Image(.happiness2), Image(.happiness3), Image(.happiness4)]

    // Level 2
    static var contempt: [Image] = [Image(.contempt1), Image(.contempt2), Image(.contempt3), Image(.contempt4)]
    static var disgust: [Image] = [Image(.disgust1), Image(.disgust2), Image(.disgust3), Image(.disgust4)]
    static var excitement: [Image] = [Image(.excitement1), Image(.excitement2), Image(.excitement3), Image(.excitement4)]
    static var interest: [Image] = [Image(.interest1), Image(.interest2), Image(.interest3), Image(.interest4)]
    static var relief: [Image] = [Image(.relief1), Image(.relief2), Image(.relief3), Image(.relief4)]

    // Level 3
    static var anticipation: [Image] = [Image(.anticipation1), Image(.anticipation2), Image(.anticipation3), Image(.anticipation4)]
    static var boredom: [Image] = [Image(.boredom1), Image(.boredom2), Image(.boredom3), Image(.boredom4)]
    static var confusion: [Image] = [Image(.confusion1), Image(.confusion2), Image(.confusion3), Image(.confusion4)]
    static var contentment: [Image] = [Image(.contentment1), Image(.contentment2), Image(.contentment3), Image(.contentment4)]
    static var embarrassment: [Image] = [Image(.embarrassment1), Image(.embarrassment2), Image(.embarrassment3), Image(.embarrassment4)]

    // Level 4
    static var envy: [Image] = [Image(.envy1), Image(.envy2), Image(.envy3), Image(.envy4)]
    static var guilt: [Image] = [Image(.guilt1), Image(.guilt2), Image(.guilt3), Image(.guilt4)]
    static var pride: [Image] = [Image(.pride1), Image(.pride2), Image(.pride3), Image(.pride4)]
    static var shame: [Image] = [Image(.shame1), Image(.shame2), Image(.shame3), Image(.shame4)]
}


