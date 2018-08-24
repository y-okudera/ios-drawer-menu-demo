//
//  AppDelegate.swift
//  ios-drawer-menu-demo
//
//  Created by YukiOkudera on 2018/08/24.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: JobListBuilder().build())
        window?.rootViewController = nc
        return true
    }
}
