//
//  UIImage+GT.swift
//  GoldTreasure
//
//  Created by ZZN on 2016/7/5.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import Foundation
enum DlOemImageGradualType {
    
    case leftToRight            // 左右
    case topToBottom            // 上下
    case leftTopCornerToR       // 对角线 左上 右下
    case leftBottomCornerToR    // 对角线 左下 右上
}


extension UIImage {
    
    /** 通过颜色生成图片 */
    class func initWith(color:UIColor) -> UIImage {
        
        let rect = CGRect(x:0, y:0, width:100, height:100)
        UIGraphicsBeginImageContext(rect.size)
        //获取上下文
        let context = UIGraphicsGetCurrentContext()
        //填充颜色
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    // 兼容oc
    class func initWithGradualColor(start:UIColor,end:UIColor,size:CGSize,type:DlOemImageGradualType) -> UIImage {
       
        return initWithGradualColor(startColor: start, endColor: end, size: size, type: type)
        
    }
    
    
    /** 背景渐变颜色生成图片 */
    class func initWithGradualColor(startColor:UIColor,endColor:UIColor,size:CGSize? = nil,type:DlOemImageGradualType? = nil) -> UIImage {
        
        var image = UIImage()
        
        let newSize = size ?? CGSize(width: 100, height: 100)
        let newType = type ?? .leftToRight

        UIGraphicsBeginImageContextWithOptions(newSize, true, 1)
        
        guard let context = UIGraphicsGetCurrentContext() else { return image }
        context.saveGState()
        
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        

        guard let startColorComponents = startColor.cgColor.components else { return image }
        guard let endColorComponents = endColor.cgColor.components else { return image }
        
        let locations:[CGFloat] = [0.0, 1.0]
        

        
        let component = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        let gradient = CGGradient.init(colorSpace: colorSpaceRef, colorComponents: component, locations: locations, count: 2)
        
        var startPoint = CGPoint(x: 0, y: 0)
        var endPoint = CGPoint(x: newSize.width, y: 0)
        
        
        switch newType {
        case .leftToRight:
            break
            
        case .topToBottom:
            
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: 0, y: newSize.height)
        case .leftTopCornerToR:
            
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = CGPoint(x: newSize.width, y: newSize.height)
        case .leftBottomCornerToR:
            
            startPoint = CGPoint(x: 0, y: newSize.height)
            endPoint = CGPoint(x: newSize.width, y: newSize.height)
        }
        
        
        
        
        
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: [.drawsBeforeStartLocation,.drawsAfterEndLocation])
        
        image = UIGraphicsGetImageFromCurrentImageContext()!;
        
        
        
        UIGraphicsEndImageContext()
        context.restoreGState()
        
        return image
    }
    
    //
//    func blur(closure:@escaping (_ image:UIImage)->()) {
//        
//        
//        DispatchQueue.global().async {
//            
//            let ciImage = CIImage.init(image: self)
//            
//            let filter = CIFilter.init(name: "CIGaussianBlur")!
//            filter.setValue(ciImage, forKey: kCIInputImageKey)
//            filter.setValue("8", forKey: "inputRadius")
//            
//            
//            let context = CIContext.init(options: nil)
//            let res = filter.value(forKey: kCIOutputImageKey) as!CIImage
//            let out = context.createCGImage(res, from: res.extent)
//            
//            let image = UIImage.init(cgImage: out!)
//            
//            closure(image)
//            
//        }
//}
}
