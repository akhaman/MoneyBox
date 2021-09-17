//
//  UINavigationController.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

extension UINavigationController {
    
    convenience init(
        root: UIViewController,
        style: NavBarStyle
    ) {
        self.init(rootViewController: root)
        
        switch style {
        case .clear:
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .filled:
            break
        }
    }

    enum NavBarStyle {
        case clear
        case filled
    }
}
