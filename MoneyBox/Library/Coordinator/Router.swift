//
//  Router.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 14.09.2021.
//

import UIKit

// MARK: - Router

protocol Router: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, hideBottomBar: Bool)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}

// MARK: - RouterImpl

final class RouterImpl: NSObject, Router {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hideBottomBar: Bool)  {
        push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent(),
              !(controller is UINavigationController) else {
            return assertionFailure("Deprecated push UINavigationController.")
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        guard let popedController = rootController?.popViewController(animated: animated) else { return }
        runCompletion(for: popedController)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        guard let popedControllers = rootController?.popToRootViewController(animated: animated) else { return }
        popedControllers.forEach { runCompletion(for: $0) }
    }
    
    private func runCompletion(for controller: UIViewController) {
        completions.removeValue(forKey: controller)?()
    }
}
