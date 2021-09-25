//
//  Routable.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

protocol Routable: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, hidesBottomBarWhenPushed: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hidesBottomBarWhenPushed: Bool, completion: (() -> Void)?)
    func popModule()
    func popModule(animated: Bool)
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, isNavigationBarHidden: Bool)
    func popToRootModule(animated: Bool)
}
