//
//  OEditController.swift
//  YPHua
//
//  Created by ZZN on 2017/11/1.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit

class OEditController: WPViewController {

    var model:ONoteRealmModel?
    var editBtn:UIButton?
    var saveBar:UIBarButtonItem?
    var isEditingFlag:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        saveBar = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.done, target: self, action: #selector(saveToDB))

        navigationItem.rightBarButtonItem = saveBar

        
        title = model?.dayDateStr

        saveBar?.isEnabled = false
        self.stopEditing()
    }


    @objc func saveToDB() {


        let newModel = ONoteRealmModel()

        newModel.title =  self.titleText
        newModel.contentText = self.bodyText
        newModel.contentHtml = self.bodyText

        newModel.updateTimeInterval =  Int(Date().timeIntervalSince1970)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        newModel.dayDateStr = dateFormatter.string(from: Date())
        newModel.timeInterval = model?.timeInterval ?? Int(Date().timeIntervalSince1970)

        if newModel.title == nil && newModel.contentText == nil {
            DlOemHUD.showError(title: "请输入日记信息")
            return
        }
        
        newModel.uid = OUser.getUserId()

        let realm = RLMRealm.default()
        realm.beginWriteTransaction()
        realm.addOrUpdate(newModel)
        try? realm.commitWriteTransaction()

        DlOemHUD.showSuccess(title: "保存成功")
        self.navigationController?.popViewController(animated: true)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
    }

    func initView() {

        editBtn = UIButton()
        
        let img = OCommon.getImg(withName: "gai-dl")
        editBtn?.setBackgroundImage(img, for: UIControlState.normal)
        
        view.addSubview(editBtn!)
        editBtn?.snp.makeConstraints({ (make) in

            make.bottom.equalTo(-80)
            make.right.equalTo(-26)
        })

        editBtn?.bk_(whenTapped: { [weak self] in

            if self?.isEditing() == false {

                self?.isEditingFlag = true
                self?.saveBar?.isEnabled = true
                self?.startEditing()
            } else {

                self?.stopEditing()
            }
        })
    }



    override func editorDidFinishLoadingDOM(_ editorController: WPEditorViewController!) {

        self.titleText = model?.title
        self.bodyText = model?.contentText
    }


}


extension OEditController:UINavigationBarDelegate {

    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {

        if isEditingFlag == true {

            DlOemHUD.showAlert(content: "是否退出", trueTitle: "是", cancelTitle: "否", trueCol: { [weak self] in

                self?.navigationController?.popViewController(animated: true)
                self?.isEditingFlag = false

            }, cancelCol: {
                
            })
            return false
        }

        return true
    }
}


