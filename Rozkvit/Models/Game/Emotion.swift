//
//  Emotion.swift
//  Rozkvit
//
//  Created by Dmytro Pogrebniak on 15.01.2024.
//

import SwiftUI

enum Emotion: CaseIterable {
    case fear
    case sadness
    case surprise
    case happiness
    case anger

    var title: String {
        switch self {
        case .fear:         return localStr("game.emotion.fear.title")
        case .sadness:      return localStr("game.emotion.sadness.title")
        case .surprise:     return localStr("game.emotion.surprise.title")
        case .happiness:    return localStr("game.emotion.happiness.title")
        case .anger:        return localStr("game.emotion.anger.title")
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
        }
    }

    var allEmotionsExceptCurrent: [Emotion] {
        var allEmotions = Emotion.allCases
        allEmotions.removeAll { $0 == self }
        return allEmotions.shuffled()
    }
}

struct Images {
    static var anger: [Image] = [Image(.anger1), Image(.anger2), Image(.anger3), Image(.anger4)]
    static var fear: [Image] = [Image(.fear1), Image(.fear2), Image(.fear3), Image(.fear4)]
    static var sadness: [Image] = [Image(.sadness1), Image(.sadness2), Image(.sadness3), Image(.sadness4)]
    static var surprise: [Image] = [Image(.surprise1), Image(.surprise2), Image(.surprise3), Image(.surprise4)]
    static var happiness: [Image] = [Image(.happiness1), Image(.happiness2), Image(.happiness3), Image(.happiness4)]
}


