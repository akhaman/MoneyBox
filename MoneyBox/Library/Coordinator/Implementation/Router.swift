//
//  Router.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 19.09.2021.
//

import UIKit

final class Router: NSObject, Routable {
    
    private var navigationController: UINavigationController?
    private var completions = [UIViewController : () -> Void]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController?.delegate = self
    }
    
    var toPresent: UIViewController? {
        navigationController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        navigationController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hidesBottomBarWhenPushed: Bool)  {
        push(module, animated: true, hidesBottomBarWhenPushed: hidesBottomBarWhenPushed, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hidesBottomBarWhenPushed: false, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, hidesBottomBarWhenPushed: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent,
              !(controller is UINavigationController) else {
            return assertionFailure("Deprecated push UINavigationController.")
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        guard let popedController = navigationController?.popViewController(animated: animated) else { return }
        runCompletion(for: popedController)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, isNavigationBarHidden: false)
    }
    
    func setRootModule(_ module: Presentable?, isNavigationBarHidden: Bool) {
        guard let controller = module?.toPresent else { return }
        navigationController?.setViewControllers([controller], animated: false)
        navigationController?.isNavigationBarHidden = isNavigationBarHidden
    }
    
    func popToRootModule(animated: Bool) {
        guard let poppedControllers = navigationController?.popToRootViewController(animated: animated) else { return }
        poppedControllers.forEach { runCompletion(for: $0) }
    }
    
    private func runCompletion(for controller: UIViewController) {
        let completion = completions.removeValue(forKey: controller)
        completion?()
    }
}

// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(poppedViewController) else { return }
        runCompletion(for: poppedViewController)
    }
}
