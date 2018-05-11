//
//  AppDelegate.swift
//  DlOemMoudle
//
//  Created by ZZN on 05/08/2018.
//  Copyright (c) 2018 ZZN. All rights reserved.
//

import UIKit
import DlOemMoudle

import RxCocoa
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        let rootNav = OCommon.getDlOemStory()?.instantiateInitialViewController()
        
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = rootNav
        window?.makeKeyAndVisible()
        
        
        
        let textF = UITextField()
        
        let singal = textF.rx.text.map { (str) -> Bool in
            
            return false
        }
 
        
        return true
    }
    
    public var isEnabled: Binder<Bool> {
        
        return Binder.init(self, binding: { (vc, isOk) in
            
        })
    }
}

