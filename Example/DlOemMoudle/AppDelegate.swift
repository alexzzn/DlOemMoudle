//
//  AppDelegate.swift
//  DlOemMoudle
//
//  Created by ZZN on 05/08/2018.
//  Copyright (c) 2018 ZZN. All rights reserved.
//

import UIKit
import DlOemMoudle

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        let rootNav = OCommon.getDlOemStory()?.instantiateInitialViewController()
        
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = rootNav
        window?.makeKeyAndVisible()
        
        return true
    }
}

