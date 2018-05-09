//
//  UIViewController+GT.swift
//  GoldTreasure
//
//  Created by ZZN on 2017/8/17.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit

var navBarBgKey = "NAVBARBGKEY"
var UserInteractionEnabled = "NAVBARTINTCOLORBGKEY"
//@nonobjc static var navTintColorKey = "NAVTINTCOLORBGKEY"

extension UIViewController {
    
    //    // 设置navbar 背景图片  =nil 显示 navbarTintColor， !=nil 显示image barTintColor 不显示
    //    open var navBgImage: UIImage? {
    //
    //        get {
    //
    //            return objc_getAssociatedObject(self, &navBarBgKey) as? UIImage ?? nil
    //        }
    //        set {
    //
    //            self.navigationController?.navigationBar.setBackgroundImage(newValue, for: .default)
    //            objc_setAssociatedObject(self, &navBarBgKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    //        }
    //    }
    //
    //    /// bar color bar 颜色
    //    open var navBarTintColor: UIColor {
    //        get {
    //
    //            guard let tintColor = objc_getAssociatedObject(self, &navBarTintColorKey) as? UIColor else {
    //
    //                return self.navigationController?.navigationBar.barTintColor ?? UIColor.white
    //            }
    //            return tintColor
    //        }
    //        set {
    //
    //            navigationController?.navigationBar.barTintColor = newValue
    //            objc_setAssociatedObject(self, &navBarTintColorKey,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    //        }
    //    }
    
    /// 设置 侧滑 手势
    open var navbarInteractionEnabled: Bool {
        get {
            
            guard let isEnabled = objc_getAssociatedObject(self, &UserInteractionEnabled) as? Bool else {
                
                return true
            }
            return isEnabled
        }
        set {
            
            objc_setAssociatedObject(self, &UserInteractionEnabled,newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    
    // 状态栏透明 （设置 透明 image）
    func transNavBar(isTrue:Bool) {
        
        if isTrue {
            
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            //            hiddenNavBarShadowLine()
        } else {
            
            // 默认
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            //            showNavBarShadowLine()
            navigationController?.navigationBar.shadowImage = nil
            setDefaultNavbarStyle()
        }
    }
    
    // 设置默认导航栏 bar 样式
    func setDefaultNavbarStyle() {
        
        //TODO:
        //        let nav = self.navigationController as? GTRootNavVC
        //        nav?.setDefaultStyle()
    }
    
    // 设置导航栏 背景色
    
    //TODO:
    
    //    // 隐藏 line
    //    private func hiddenNavBarShadowLine() {
    //
    //
    //        let lineView = self.findHairlineImageViewUnder(navigationController?.navigationBar)
    //        lineView?.isHidden = true;
    //    }
    //    // 显示 line
    //    private func showNavBarShadowLine() {
    //
    //        let lineView = self.findHairlineImageViewUnder(navigationController?.navigationBar)
    //        lineView?.isHidden = false;
    //    }
    
    
}
