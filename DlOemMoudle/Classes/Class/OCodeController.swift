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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        codeTF.rx.text.bind { [weak self] str in
            
            guard let nStr = str else { return }
            
            if nStr.count >= 4 {

                self?.codeTF.text = str?.subToOffset(right: 4)
                self?.loginIn()
            }
        }.disposed(by:dispose)

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


    // 登录
    func sendCode() {

        let url = "https://baidu.com"

        let companyId = String.init(format: "%d", 1000)
        let params = ["phoneNo":"\(phoneNum ?? "")","type":"1","companyId":companyId]

        let jsonData = try? JSON.init(params).rawData()
        var req = try? URLRequest.init(url: url, method: .post)
        req?.httpBody = jsonData

        request(req!).responseData { [weak self] (res) in


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

        let url = "https://baidu.com"
        var params = [String:String]()// ["phoneNo":"17858656212","code":"6949"]

        params["phoneNo"] = phoneNum
        params["code"] = codeTF.text

        let jsonData = try? JSON.init(params).rawData()
        var req = try? URLRequest.init(url: url, method: .post)
        req?.httpBody = jsonData

        DlOemHUD.showStatus(title: "登录中...")
        request(req!).responseData { [weak self] (res) in


            DlOemHUD.dismiss()
            
            OUser.setLogin(islogin: true)
            self?.navigationController?.dismiss(animated: true, completion: nil)

            //            if res.result.isSuccess  {
            //
            //            } else {
            //                DlOemHUD.showError(title: "登录失败，请重新输入验证码")
            //            }
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
