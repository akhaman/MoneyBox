//
//  UIViewController+.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 02.11.2021.
//

import UIKit

extension UIViewController {

    var isRootInNavigationController: Bool {
        return navigationController?.viewControllers.first === self
    }

    var isPresentedController: Bool {
        let mainController = navigationController ?? self
        return mainController.presentingViewController != nil
    }
}
