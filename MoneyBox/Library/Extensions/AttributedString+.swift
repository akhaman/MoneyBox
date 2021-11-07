//
//  AttributedString+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import UIKit

extension NSAttributedString {
    
    var fullRange: NSRange {
        NSRange(location: 0, length: length)
    }
}

extension String {

    var fullRange: NSRange {
        NSRange(location: 0, length: count)
    }

    var attributed: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}

extension NSMutableAttributedString {
    func with(font: UIFont, range: NSRange? = nil) -> NSMutableAttributedString {
        self.addAttribute(.font, value: font, range: range ?? fullRange)
        return self
    }

    func with(color: UIColor?, range: NSRange? = nil) -> Self {
        guard let color = color else { return self }
        addAttribute(.foregroundColor, value: color, range: range ?? fullRange)
        return self
    }

    func with(color: UIColor, substring: String) -> Self {
        guard let substringRange = string.range(of: substring) else { return self }
        let range = NSRange(substringRange, in: string)
        addAttribute(.foregroundColor, value: color, range: range)
        return self
    }

    func withParagraph(
        lineSpacing: CGFloat,
        lineBreak: NSParagraphStyle.LineBreakStrategy = .pushOut,
        alignment: NSTextAlignment = .left,
        range: NSRange? = nil
    ) -> Self {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakStrategy = lineBreak
        addAttribute(.paragraphStyle, value: paragraphStyle, range: range ?? fullRange)
        return self
    }

    func with(stringUrl: String, range: NSRange? = nil) -> Self {
        addAttribute(.link, value: stringUrl, range: range ?? fullRange)
        return self
    }

    func with(stringUrl: String, substring: String) -> Self {
        guard let substringRange = string.range(of: substring) else { return self }
        let range = NSRange(substringRange, in: string)
        addAttribute(.link, value: stringUrl, range: range)
        return self
    }
}
