//
//  CGRect+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

extension CGRect {
    init(origin: CGPoint = .zero, width: CGFloat = .zero, height: CGFloat = .zero) {
        self.init(origin: origin, size: CGSize(width: width, height: height))
    }
}
