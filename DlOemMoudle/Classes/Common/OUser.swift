//
//  OUser.swift
//  YWallet
//
//  Created by ZZN on 2017/10/12.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import RxSwift

class OUser: NSObject {

    // 监听网络连接
    private var changedInfoBlock:((_ model:DlOemResCommonM)->Void)?
    let dispostBag = DisposeBag()

    //登录成功后
    var userInfoModel:DlOemUserInfoM? {
        
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "OUSERMODELCHANGENOTI"), object: nil)
        }
    }

    // 显示登录页面操作
    func loginIn(succ:((_ model:DlOemResCommonM)->Void)? = nil,fail:((_ err:DlOemError)->Void)? = nil) {

        let vc = UINavigationController()
//        guard let loginVC = vc?.viewControllers.first else { return }
//
//        loginVC.loginIn(succ: { (model) in
//
//
//            let resModel = model
//            if succ != nil { succ!(resModel) }
//
//        }) { (err) in
//
//            if fail != nil { fail!(err) }
//        }
        DlOemHUD.currentNav().present(vc, animated: true, completion: nil)
    }
    // 退出登录
    func logoutWith(title:String?,proTitle:String?, succ:(()->Void)?,fail:(()->Void)?) {

        OUser.setLogin(islogin: false)
        DlOemHUD.showStatus(title: proTitle ?? "")

        let time: TimeInterval = 1.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {

            //code
            DlOemHUD.showSuccess(title: title ?? "退出成功")
            if succ != nil { succ!() }
        }
    }
    // 销毁
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //管理实例
    static let manger:OUser = {

        let instance = OUser()
        return instance
    }()

    private override init() {
        super.init()
    }
}

// 类方法
extension OUser {
    //是否登陆
    class func isLogin() -> Bool {

        let bools = UserDefaults.standard.bool(forKey: "OUSERISLOGIN")
        debugPrint(bools)
        return bools
    }

    //设置登陆状态
    class func setLogin(islogin:Bool) {

        if islogin == false {

            // TODO
            setUserId(text: "")
            setToken(text: "")
            
        } 

         UserDefaults.standard.set(islogin, forKey: "OUSERISLOGIN")
        let bools = islogin
        debugPrint(bools)
    }


    class func setPhoneNo(text:String) {

        UserDefaults.standard.set(text, forKey: "OPHONE")
    }

    class func getPhoneNo() ->String {

        let str = UserDefaults.standard.object(forKey: "OPHONE") as? String ?? "-"
        debugPrint(str)
        return str
    }


    class func setToken(text:String) {

        UserDefaults.standard.set(text, forKey: "otoken")
    }

    class func getToken() ->String {

        let str = UserDefaults.standard.object(forKey: "otoken") as? String ?? "-"
        debugPrint(str)
        return str
    }


    class func setUserId(text:String) {

        UserDefaults.standard.set(text, forKey: "odluserid")
    }

    class func getUserId() ->String {

        let str = UserDefaults.standard.object(forKey: "odluserid") as? String ?? "-"
        debugPrint(str)
        return str
    }
}
