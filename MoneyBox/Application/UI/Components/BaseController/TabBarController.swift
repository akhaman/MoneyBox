//
//  TabBarController.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit

protocol TabBarModule: Presentable {
    func configure(with items: [TabBarItem], selectedIndex: Int)
}

struct TabBarItem {
    let title: String
    let icon: UIImage
    let presentable: Presentable?
    let onSelect: VoidClosure
}

final class TabBarController: UITabBarController, TabBarModule {
    private var tagClosureMap: [Int: VoidClosure] = [:]

    func configure(with items: [TabBarItem], selectedIndex: Int) {
        let mappedItems = items.compactMap { item -> (vc: UIViewController, tag: Int, action: VoidClosure)? in
            guard let viewController = item.presentable?.toPresent else { return nil }
            viewController.tabBarItem = UITabBarItem(title: item.title, image: item.icon, tag: viewController.hashValue)
            return (viewController, viewController.hashValue, item.onSelect)
        }

        mappedItems.forEach { tagClosureMap[$0.tag] = $0.action }
        setViewControllers(mappedItems.map { $0.vc }, animated: false)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tagClosureMap[item.tag]?()
    }
}
