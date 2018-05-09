//
//  UILabel+QM.swift
//  QianmiQB
//
//  Created by lemac on 2017/3/14.
//  Copyright © 2017年 Qianmi Network. All rights reserved.
//

import UIKit


extension UILabel {

    class func labWithDetails(labName:String?,fontSize:CGFloat,titleColor:UIColor,Alignment:NSTextAlignment?) ->UILabel{
        let lab = UILabel(frame: CGRect.zero)
        
        if labName == nil {
            lab.text = ""
        } else {
            lab.text = labName
        }
        if Alignment != nil {
            lab.textAlignment = Alignment!
        }
//        
//        if IPHONE6UP {
//            lab.font = UIFont.systemFont(ofSize: fontSize)
//        }else {
//            lab.font = UIFont.systemFont(ofSize: fontSize - 2)
//        }
        
        lab.textColor = titleColor
        //        lab.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        lab.adjustsFontSizeToFitWidth = false
        lab.numberOfLines = 0
        return lab
    }
}
