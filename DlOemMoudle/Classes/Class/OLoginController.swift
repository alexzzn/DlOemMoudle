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
    @IBOutlet weak var loginBtn: UIButton!


    var dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signal = phoneTF.rx.text.map { [weak self] (v) -> Bool in
            
            guard let nv = v  else { return false }
            
            if  nv.count == 0 {
                
                return false
            } else if nv.count >= 11 {
                
                self?.phoneTF.text = nv.subToOffset(right: 11)
                return true
            } else {
                
                return false
            }
        }
        
        signal.bind(to: loginBtn.rx.isEnabled).disposed(by: dispose)
        
        //
        loginBtn.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] () in
            
            let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OCodeController") as?OCodeController
            
            vc?.phoneNum = self.phoneTF.text
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }).disposed(by: dispose)
        
    }
}
