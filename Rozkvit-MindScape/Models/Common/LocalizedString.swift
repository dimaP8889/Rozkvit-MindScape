//
//  LocalizedString.swift
//  Rozkvit-MindScape
//
//  Created by Dmytro Pogrebniak on 18.03.2024.
//

import SwiftUI
import UIKit

struct LocalizedString: ExpressibleByStringLiteral {
    var key: String

    init(_ key: String) {
        self.key = key
    }

    init(stringLiteral value: StringLiteralType) {
        self.key = value
    }

    func resolve() -> String {
        localStr(key)
    }
}

extension LocalizedString {
    typealias Fonts = (default: UIFont, bold: UIFont)

    static func defaultFonts() -> Fonts {
        let font = UIFont.preferredFont(forTextStyle: .body)
        return (font, .boldSystemFont(ofSize: font.pointSize))
    }

    func attributedString(
        withFonts fonts: Fonts = defaultFonts()
    ) -> NSAttributedString {
        render(
            into: NSMutableAttributedString(),
            handler: { fullString, string, isBold in
                let font = isBold ? fonts.bold : fonts.default

                fullString.append(NSAttributedString(
                    string: string,
                    attributes: [.font: font]
                ))
            }
        )
    }
}

private extension LocalizedString {
    func render<T>(
        into initialResult: T,
        handler: (inout T, String, _ isBold: Bool) -> Void
    ) -> T {
        let components = resolve().components(separatedBy: "**")
        let sequence = components.enumerated()

        return sequence.reduce(into: initialResult) { result, pair in
            let isBold = !pair.offset.isMultiple(of: 2)
            handler(&result, pair.element, isBold)
        }
    }
}

extension LocalizedString {
    func styledText() -> Text {
        render(into: Text("")) { fullText, string, isBold in
            var text = Text(string)

            if isBold {
                text = text.bold()
            }

            fullText = fullText + text
        }
    }
}
