//
//  BarButtonItem.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 10.09.2021.
//

import UIKit

class BarButtonItem: UIBarButtonItem {

    private let onTap: VoidClosure
    
    // MARK: - Init

    init(type: ItemType, onTap: @escaping VoidClosure) {
        self.onTap = onTap
        super.init()
        
        target = self
        action = #selector(itemTapped)
        image = type.iconImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc private func itemTapped() {
        onTap()
    }

    // MARK: - Type

    enum ItemType {
        case add
        case close
    }
}

private extension BarButtonItem.ItemType {
    
    var iconImage: UIImage {
        switch self {
        case .add:
            return Image.Icon.add.image
        case .close:
            return Image.Icon.close.image
        }
    }
}
