//
//  OFeedBackVC.swift
//  YPHua
//
//  Created by ZZN on 2017/11/3.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit

class OFeedBackVC: UIViewController {

    @IBOutlet weak var titleLab: UITextField!

    @IBOutlet weak var textV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()


        let bar = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(send))
        navigationItem.rightBarButtonItem = bar
    }

    @objc func send() {


        let conut1 = titleLab.text?.characters.count ?? 0
        if (conut1>0) == false {

            DlOemHUD.showError(title: "请输入联系方式")
            return
        }

        let conut2 = textV.text?.characters.count ?? 0
        if conut2 < 1 {

            DlOemHUD.showError(title: "请输入反馈内容")
            return
        }

        DlOemHUD.showStatus(title: nil)
        OCommon.requestNet { [weak self] in

            DlOemHUD.showSuccess(title: "提交完成")
            self?.navigationController?.popViewController(animated: true)
        }

    }
}
