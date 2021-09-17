//
//  AppDelegate.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 08.09.2021.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let applicationFactory: ApplicationFactory = ApplicationFactoryImpl()
    
    var coordinator: Coordinator?
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let (window, coordinator) = applicationFactory.makeWindowWithCoordinator()
        self.window = window
        self.coordinator = coordinator
        coordinator.start()
        return true
    }
}
