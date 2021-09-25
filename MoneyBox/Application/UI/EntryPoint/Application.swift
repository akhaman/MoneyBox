//
//  Application.swift
//  MoneyBox
//
//  Created by Ruslan Akhmadeev on 18.09.2021.
//

import UIKit
import DITranquillity

enum Application {
    private static let container = DIContainer()
    private static let coordinator: ApplicationFlow = container.resolve()

    static func initialize() {
        AppDependency.configure()
        AppDependency.register(inContainer: container)
    }

    static func configure(window: UIWindow) {
        window.rootViewController = coordinator.toPresent
        window.makeKeyAndVisible()
    }

    static func start(withLaunchoptions options: [UIApplication.LaunchOptionsKey: Any]?) {
        coordinator.start()
    }
}
