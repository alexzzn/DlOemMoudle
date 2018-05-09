//
//  OLoginController.swift
//  YPHua
//
//  Created by ZZN on 2017/11/7.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class OLoginController: UIViewController {

    @IBOutlet weak var phoneTF: UITextField!


    @IBAction func actionJump(_ sender: UIButton) {

        if phoneTF.text?.characters.isEmpty == true {

            DlOemHUD.showToast(info: "请输入手机号")
        }
        
        let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OCodeController") as?OCodeController
        
        vc?.phoneNum = phoneTF.text
        navigationController?.pushViewController(vc!, animated: true)
    }

    var dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()



        phoneTF.rx.text.bind { [weak self] str in


            if str == nil { return }
            if str!.characters.count > 11 {

                self?.phoneTF.text = str?.subToOffset(right: 11)
            }
        }.addDisposableTo(dispose)

    }
}
