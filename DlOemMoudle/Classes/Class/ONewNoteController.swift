//
//  ONewNoteController.swift
//  YPHua
//
//  Created by ZZN on 2017/11/6.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import Realm

class ONewNoteController: WPViewController {



    var model:ONoteRealmModel?
    var editBtn:UIButton?
    var saveBar:UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        saveBar = UIBarButtonItem.init(title: "保存", style: UIBarButtonItemStyle.done, target: self, action: #selector(saveToDB))
        navigationItem.rightBarButtonItem = saveBar
        
        self.stopEditing()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        title =  dateFormatter.string(from: Date())
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = saveBar
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        self.startEditing()
    }

    @objc func saveToDB() {

        let model = ONoteRealmModel()

        model.title =  self.titleText
        model.contentText = self.bodyText
        model.contentHtml = self.bodyText


        model.timeInterval = Int(Date().timeIntervalSince1970)
        model.updateTimeInterval =  Int(Date().timeIntervalSince1970)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        model.dayDateStr = dateFormatter.string(from: Date())





        if model.title == nil && model.contentText == nil {
            DlOemHUD.showError(title: "请输入日记信息")
            return
        }

        let realm = RLMRealm.default()

        realm.beginWriteTransaction()
        realm.add(model)
        try? realm.commitWriteTransaction()

        DlOemHUD.showSuccess(title: "保存成功")
        self.navigationController?.popViewController(animated: true)
    }




    func initView() {

    }



    override func editorDidFinishLoadingDOM(_ editorController: WPEditorViewController!) {

//        self.titleText = model?.title
//        self.bodyText = model?.contentText
    }

}
