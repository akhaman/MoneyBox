//
//  UIView+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

extension UIView {
    @discardableResult
    func hide() -> Self {
        isHidden = true
        return self
    }

    @discardableResult
    func show() -> Self {
        isHidden = false
        return self
    }

    @discardableResult
    func apply(to superview: UIView) -> Self {
        superview.addSubview(self)
        self.snp.makeConstraints { $0.edges.equalToSuperview() }
        return self
    }
}
