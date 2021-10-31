//
//  NavigationBar.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 31.10.2021.
//

import UIKit

class NavigationBar: UINavigationBar {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Initial Configuration

    private func setup() {
        tintColor = Colors.primaryText.color
    }
}
