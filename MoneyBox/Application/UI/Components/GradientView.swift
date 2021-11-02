//
//  GradientView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit

class GradientView: UIView {

    override open class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
}

extension GradientView {

    static var mainBackground: GradientView {
        let view = GradientView()
        let layer = view.gradientLayer
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)

        layer.colors = [
            Colors.gradientedBgStart.color.cgColor,
            Colors.gradientedBgEnd.color.cgColor
        ]

        return view
    }

    static var secondaryBackground: GradientView {
        let view = GradientView()
        let layer = view.gradientLayer
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)

        layer.colors = [
            Colors.gradientedBg2Start.color.cgColor,
            Colors.gradientedBg2End.color.cgColor
        ]

        return view
    }
}
