//
//  ORootNav.swift
//  YPHua
//
//  Created by ZZN on 2017/11/7.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit

public class ORootNav: UINavigationController {

    override public func viewDidLoad() {
        super.viewDidLoad()

    
        navigationBar.tintColor = UIColor.darkGray
        view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.darkGray]
        } else {
            // Fallback on earlier versions
        }
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.darkGray,.font:UIFont.boldSystemFont(ofSize: 16)]
    }
}
