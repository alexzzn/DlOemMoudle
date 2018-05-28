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
import BeeHive

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        
        
        BHContext.shareInstance().application = application
        BHContext.shareInstance().launchOptions = launchOptions
        
        BeeHive.shareInstance().context = BHContext.shareInstance()
        
        
        let rootNav = ViewController()//OCommon.getDlOemStory()?.instantiateInitialViewController()
        
        rootNav.view.backgroundColor = UIColor.white
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = rootNav
        window?.makeKeyAndVisible()
        
        
        
//        let textF = UITextField()
//        
//        let singal = textF.rx.text.map { (str) -> Bool in
//            
//            return false
//        }
 
 
        
       
        //super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        
        return true
    }
    
    public var isEnabled: Binder<Bool> {
        
        return Binder.init(self, binding: { (vc, isOk) in
            
        })
    }
}

