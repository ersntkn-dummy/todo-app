//
//  AppDelegate.swift
//  TodoApp
//
//  Created by Ersen Tekin on 28/09/2019.
//  Copyright © 2019 Ersen Tekin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        var rootViewController: UIViewController
        do {
            rootViewController = try TodoListFactory.createTodoListModule()
        } catch TodoListFactoryError.storyboardInstantiation(let identifier) {
            fatalError("could not find ViewController with id: \(identifier)")
        } catch {
            fatalError()
        }

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
}
