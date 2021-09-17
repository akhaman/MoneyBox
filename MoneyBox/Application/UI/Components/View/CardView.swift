//
//  CardView.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 09.09.2021.
//

import UIKit

class CardView: UIView {
    
    private let cornerRadius: CGFloat
    private var animationsEnabled = true
    
    // MARK: - LifeCycle
    
    init(frame: CGRect = .zero, cornerRadius: CGFloat = 12) {
        self.cornerRadius = cornerRadius
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = 1
        layer.shadowColor = Colors.shadow.color.cgColor
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Updating
    
    func set(highlighted: Bool) {
        guard animationsEnabled else { return }
        
        let transform = highlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.allowUserInteraction, .curveEaseInOut, .beginFromCurrentState]
        ) {
            self.transform = transform
        }
    }
    
    @discardableResult
    func enableAnimations() -> Self {
        animationsEnabled = true
        return self
    }
    
    @discardableResult
    func disableAnimations() -> Self {
        animationsEnabled = false
        return self
    }
    
    @discardableResult
    func enableShadows() -> Self {
        layer.shadowOpacity = 1
        return self
    }
    
    @discardableResult
    func disableShadows() -> Self {
        layer.shadowOpacity = 0
        return self
    }
}
