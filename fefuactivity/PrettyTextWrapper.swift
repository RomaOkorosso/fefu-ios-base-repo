//
//  File.swift
//
//
//  Created by Роман Есин on 21.12.2021.
//

import UIKit

public struct ColoredText: ExpressibleByStringLiteral, ExpressibleByStringInterpolation {
    public struct StringInterpolation: StringInterpolationProtocol {
        var output = NSMutableAttributedString(string: "")
        var clickableTexts: [NSRange: (String) -> Void] = [:]

        public init(literalCapacity: Int, interpolationCount: Int) {}

        mutating public func appendLiteral(_ literal: String) {
            output.append(.init(string: literal))
        }

        mutating public func appendInterpolation(_ str: String, color: UIColor, onClick: ((String) -> Void)? = nil) {
            let attrString = NSMutableAttributedString(string: str)
            let range = (str as NSString).range(of: str)
            attrString.addAttributes([.foregroundColor: color], range: range)

            let clickRange = NSRange(location: output.length, length: attrString.length)
            clickableTexts[clickRange] = onClick
            output.append(attrString)

        }

        mutating public func appendInterpolation(_ str: NSAttributedString) {
            output.append(str)
        }
    }

    public var output: NSAttributedString
    public var clickableTexts: [NSRange: (String) -> Void]

    public init(stringLiteral value: String) {
        output = NSAttributedString(string: value)
        clickableTexts = [:]
    }

    public init(stringInterpolation: StringInterpolation) {
        output = stringInterpolation.output
        clickableTexts = stringInterpolation.clickableTexts
    }
}

public extension String {
    func colored(_ color: UIColor) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: self)
        attrString.addAttributes([.foregroundColor: color], range: range)

        return attrString
    }
}
