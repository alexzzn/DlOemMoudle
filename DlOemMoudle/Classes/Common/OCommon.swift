//
//  OCommon.swift
//  YWallet
//
//  Created by ZZN on 2016/10/11.
//  Copyright © 2016年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AssetsLibrary

class DlOemError:Error {
    
}

public class OCommon: NSObject {

    
    // 获取storyboard
    public class func getDlOemStory() -> UIStoryboard? {
        
        let moudleFileBundle = Bundle.init(for: self.classForCoder())
        
        let story = UIStoryboard.init(name: "OController", bundle: moudleFileBundle)
        return story
    }
    
    // 获取资源图片
    class func getImg(withName:String) -> UIImage? {
        
        let moudleFileBundle = Bundle.init(for: self.classForCoder())
        let img = UIImage.init(named: withName, in: moudleFileBundle, compatibleWith: nil)
        return img
    }
    
    // 模拟网络
    public class func requestNet(next:@escaping ()->Void) {

        // 随机访问 暂不做处理
        let url = "https://v.juhe.cn/certificates/typeList.php?key=JH12ab0b80eb3d87ae0835891ac6cbd835"


        request(url).response { (res) in

        }

        // 模拟延迟
        let timeInter = Double(arc4random()%15)/15 +  Double(arc4random()%10)/15
        debugPrint(timeInter)

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInter) {

            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            GTHUD.dismiss()
            next()
        }

    }
}



class OTakePhotoVC: UIViewController {

    fileprivate var closure:((_ img:Data)->())?
    lazy var picker:UIImagePickerController = {
        return UIImagePickerController.init()
    }()
    //
    static let shared:OTakePhotoVC = {
        let instance = OTakePhotoVC()
        return instance
    }()

    //照相
    func takePhoto(done:@escaping (_ img:Data)->()) {


        picker.delegate = self

        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        if (authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied) {

            let alert = UIAlertView.init(title: nil, message: "设置-隐私-照片 选项中允许程序访问你的相机", delegate: nil, cancelButtonTitle: "好的")
            alert.show()
            return
        }

        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {

            let alert = UIAlertView.init(title: nil, message: "相机不可用", delegate: nil, cancelButtonTitle: "好的")
            alert.show()
            return
        }

        closure = done

        picker.sourceType = UIImagePickerControllerSourceType.camera
        DlOemHUD.currentNav().present(picker, animated: true, completion: nil)
    }
    //获取相册
    func getPhotoFromAlbum(done:@escaping (_ img:Data)->()) {

        picker.delegate = self

        let authStatus = ALAssetsLibrary.authorizationStatus()

        if (authStatus == ALAuthorizationStatus.restricted || authStatus == ALAuthorizationStatus.denied) {

            let alert = UIAlertView.init(title: nil, message: "设置-隐私-照片 选项中允许程序访问你的相册", delegate: nil, cancelButtonTitle: "好的")
            alert.show()
            return
        }

        if (!UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)) {

            let alert = UIAlertView.init(title: nil, message: "相册不可用", delegate: nil, cancelButtonTitle: "好的")
            alert.show()
            return
        }

        closure = done

        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        DlOemHUD.currentNav().present(picker, animated: true, completion: nil)
    }


}

extension OTakePhotoVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        picker.dismiss(animated: true, completion: nil)
        let type = info[UIImagePickerControllerMediaType] as? String

        if type == "public.image" {

            let img = info[UIImagePickerControllerOriginalImage] as? UIImage
            guard let imgdata = UIImageJPEGRepresentation(img!, 0.2) else { return }

            if closure != nil {

                closure!(imgdata)
            }
        }
    }

}



