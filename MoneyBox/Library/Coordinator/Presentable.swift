//
//  Presentable.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit

protocol Presentable {
  func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
  
  func toPresent() -> UIViewController? {
    return self
  }
}
