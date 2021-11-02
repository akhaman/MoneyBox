//
//  UIStackView+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 02.11.2021.
//

import UIKit

extension UIStackView {

    convenience init(_ arrangedSubviews: UIView...) {
        self.init(arrangedSubviews: arrangedSubviews)
    }

    @discardableResult
    func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    @discardableResult
    func alignment(_ alignment: Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
}
