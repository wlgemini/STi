//
//  AppDelegate.swift
//  STi
//
//  Created by wangluguang@live.com on 05/24/2019.
//  Copyright (c) 2019 wangluguang@live.com. All rights reserved.
//

import UIKit
import STi

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let nav = UINavigationController(rootViewController: MyViewController(), preference: nil)
        self.window = Window.createWindow(for: Window.Level.main)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = nav
        
        Window.makeKeyAndVisibleWindow(for: Window.Level.main, visible: true)
        
        return true
    }

}

