//
//  AppDelegate.swift
//  modoTube
//
//  Created by Guillaume Monot on 7/24/17
//  Copyright (c) 2017 mobizel. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        /* IQKeyboardManager Setup */
        IQKeyboardManagerSetup()

        /* Analytics Setup */
        #if !DEBUG
            addAnalytics()
        #endif

        /* Logger */
        MTubeLogger.setup()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }
}

extension AppDelegate {

    fileprivate func IQKeyboardManagerSetup() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldShowTextFieldPlaceholder = false
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "close"
        // TODO: 📝 enable localisation for Localizable.strings, build the project and replace "close" with tr(.commonClose) (swiftgen generated string)
    }

    fileprivate func addAnalytics() {
        Fabric.with([Crashlytics.self()])
    }
}
