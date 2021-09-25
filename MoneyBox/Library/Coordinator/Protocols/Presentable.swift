//
//  Presentable.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit

protocol Presentable: AnyObject {
    var toPresent: UIViewController? { get }
}
