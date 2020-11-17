//
//  AppDelegate.swift
//  PoliciesTest
//
//  Created by Narek on 11/17/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var startCoordinator = StartCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startCoordinator.start(window?.rootViewController as? UINavigationController)
        return true
    }

}

