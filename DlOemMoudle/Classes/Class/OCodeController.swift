//
//  OCodeController.swift
//  YPHua
//
//  Created by ZZN on 2017/11/7.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire
import SwiftyJSON
import BlocksKit

class OCodeController: UIViewController {

    @IBOutlet weak var notiLab: UILabel!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var actionBtn: UIButton!

    var phoneNum:String?
    var dispose = DisposeBag()
    
    static let baseurl = "https://m.xhjlc.com/"
    
    enum OApi:String {
        
        case sendCode = "login/loginMsgSendForMJB.dos"
        case verifyCode = "login/doLoginForMJB.dos"
        
        func url() -> String {
            return baseurl + self.rawValue
        }
    }
    
    // 绑定
    var isEnabled: Binder<Bool> {
        
    
        return Binder<Bool>.init(self, binding: { (o, v) in
            
            if v == true {
                o.loginIn()
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeTF.rx.text.map { [unowned self](str) -> Bool in
            
            guard let nStr = str else { return false }
            
            if nStr.count > 4 {
                self.codeTF.text = nStr.subToOffset(right: 4)
            }
            return nStr.count == 4
            
        }.distinctUntilChanged().bind(to: isEnabled).disposed(by: dispose)
        
        actionBtn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self]() in
            
            self?.sendCode()
        }).disposed(by: dispose)
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        sendCode()

        let notiStr = "我们已向 \(phoneNum ?? "-") 发送验证码短信，请查看短信并输入验证码"
        notiLab.text = notiStr
        codeTF.becomeFirstResponder()
    }
    
    


    // 获取验证码
    func sendCode() {

        let url = OApi.sendCode.url()

        // let companyId = String.init(format: "%d", 1000)
        let params = ["mobilephone":"\(phoneNum ?? "")"]
        
        request(url, method: .post, parameters: params).responseJSON { [weak self] (res) in
            
            if res.result.isSuccess  {
                
                self?.countdown()
            } else {
                
                DlOemHUD.showError(title: "发送验证码失败")
                self?.notiLab.text = "短信发送失败，请 点击按钮 重新发送验证码"
            }
        }
        
    }

    // 登录
    func loginIn() {

        let url = OApi.verifyCode.url()
        var params = [String:String]()

        params["mobilephone"] = phoneNum
        params["smsCode"] = codeTF.text

        DlOemHUD.showStatus(title: "登录中...")
        
        
        // 校验默认帐号
        if phoneNum == "13083663880" && codeTF.text == "2647" {
            
            OCommon.requestNet { [weak self] in
                
                DlOemHUD.dismiss()
                
                OUser.setLogin(islogin: true)
                OUser.setUserId(text: "13083663880")
                
                self?.navigationController?.dismiss(animated: true, completion: nil)
            }
        } else {
            
            request(url, method: .post, parameters: params).responseData { [weak self] (res) in
                
                DlOemHUD.dismiss()
                self?.navigationController?.dismiss(animated: true, completion: nil)
                
                if res.result.isSuccess  {
                    
                    OUser.setLogin(islogin: true)
                    OUser.setUserId(text: (self?.phoneNum ?? ""))
                } else {
                    
                    DlOemHUD.showError(title: "登录失败，请重新输入验证码")
                }
            }
            return
        }
    }

    // 登录倒计时
    func countdown() {

        var count = 60//设置定时
        
        Timer.bk_scheduledTimer(withTimeInterval: 1, block: {[weak self] (time) in

            if let weakself = self {

                count -= 1
                if count == 0  {

                    weakself.actionBtn.isSelected = false
                    weakself.actionBtn.isUserInteractionEnabled = true
                    time?.invalidate()

                } else {

                    weakself.actionBtn.isSelected = true
                    weakself.actionBtn.isUserInteractionEnabled = false
                    weakself.actionBtn.setTitle("\(count)秒", for: .selected)
                }
            }
        }, repeats: true)
    }
}
