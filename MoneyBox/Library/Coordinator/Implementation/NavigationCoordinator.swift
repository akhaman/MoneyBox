//
//  NavigationCoordinator.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 19.09.2021.
//

import UIKit

class NavigationCoordinator: Coordinator {
    
    let router: Routable
    
    init(router: Routable) {
        self.router = router
    }
    
    override var toPresent: UIViewController? {
        router.toPresent
    }
}
