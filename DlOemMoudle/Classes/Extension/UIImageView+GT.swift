//
//  UIImageView+GT.swift
//  GoldTreasure
//
//  Created by ZZN on 2017/8/16.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import ObjectiveC

fileprivate typealias TapBlock = () -> Void
fileprivate var BLOCKKEY = "BLOCKKEY"

extension UIImageView {
    
    
    func tap(blcok:@escaping ()->Void) {
        
        self.isUserInteractionEnabled = true
        let gesture = UIGestureRecognizer.init(target: self, action: #selector(handle))
        addGestureRecognizer(gesture)
        self.myBlock = blcok
    }
    
    private var myBlock: TapBlock? {
        get {
            if let myBlcok = objc_getAssociatedObject(self, &BLOCKKEY) as? TapBlock {
                return myBlcok
            }
            return nil
        }
        
        // 如果计算属性的setter没有定义表示新值的参数名，则可以用默认值newValue
        set {
            objc_setAssociatedObject(self, &BLOCKKEY, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    
    @objc private func handle() {
        if myBlock != nil {
            myBlock!()
        }
        
        debugPrint("tap")
    }
    
    
}
