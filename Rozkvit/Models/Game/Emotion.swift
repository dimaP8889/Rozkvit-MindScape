//
//  Emotion.swift
//  Rozkvit
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

    static var level1: [Emotion] = [.fear, .sadness, .surprise, .happiness, .anger]
    static var level2: [Emotion] = [.contempt, .disgust, .excitement, .interest, .relief]

    var title: String {
        switch self {
        case .fear:         return localStr("game.emotion.fear.title")
        case .sadness:      return localStr("game.emotion.sadness.title")
        case .surprise:     return localStr("game.emotion.surprise.title")
        case .happiness:    return localStr("game.emotion.happiness.title")
        case .anger:        return localStr("game.emotion.anger.title")

        case .contempt:     return localStr("game.emotion.contempt.title")
        case .disgust:      return localStr("game.emotion.disgust.title")
        case .excitement:   return localStr("game.emotion.excitement.title")
        case .interest:     return localStr("game.emotion.interest.title")
        case .relief:       return localStr("game.emotion.relief.title")
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
        case .fear:         return Images.fear.randomElement()!
        case .sadness:      return Images.sadness.randomElement()!
        case .surprise:     return Images.surprise.randomElement()!
        case .happiness:    return Images.happiness.randomElement()!
        case .anger:        return Images.anger.randomElement()!

        case .contempt:     return Images.contempt.randomElement()!
        case .disgust:      return Images.disgust.randomElement()!
        case .excitement:   return Images.excitement.randomElement()!
        case .interest:     return Images.interest.randomElement()!
        case .relief:       return Images.relief.randomElement()!
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
}


