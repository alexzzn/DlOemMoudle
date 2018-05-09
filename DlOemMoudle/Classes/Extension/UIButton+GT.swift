//
//  Data+GT.swift
//  GoldTreasure
//
//  Created by ZZN on 2017/6/30.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    // 初始化
    class func btnWith(title:(String?) = nil,titleColor:UIColor?,titleFont:UIFont? = nil,bgImage:UIImage? = nil, cornerRadius:CGFloat? = nil,state:UIControlState? = nil) -> UIButton {
        
        let btn = UIButton()
        
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = titleFont
        
        if bgImage != nil {
            btn.setImage(bgImage!, for: state ?? .normal)
        }
        btn.layer.cornerRadius = cornerRadius ?? 0
        btn.layer.masksToBounds = true
        
        return btn
    }
    
    //
    func initWith(title:(String?) = nil,titleColor:UIColor?,titleFont:UIFont? = nil,bgClolor:UIColor? = nil, cornerRadius:CGFloat? = nil,state:UIControlState? = nil) {
        
        let btn = UIButton()
        
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = titleFont
        
        if bgClolor != nil {
            btn.setImage(UIImage.initWith(color: titleColor!), for: state ?? .normal)
        }
        btn.layer.cornerRadius = cornerRadius ?? 0
        btn.layer.masksToBounds = true
        
    }
    
    
}
