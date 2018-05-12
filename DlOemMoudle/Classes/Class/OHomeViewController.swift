//
//  OHomeViewController.swift
//  YPHua
//
//  Created by ZZN on 2017/10/30.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import SwiftDate
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class OHomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var action: UIButton!

    @IBOutlet weak var yearLab: UILabel!
    @IBOutlet weak var dayLab: UILabel!
    @IBOutlet weak var weekDayLab: UILabel!
    @IBOutlet weak var zhYearLab: UILabel!

    var contentList = [RLMObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initHandle()
    }

    func initView() {

        tableView.rowHeight = 90
        tableView.tableFooterView = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground

        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月"

        yearLab.text = format.string(from: Date())
        dayLab.text = Date().day.toString()
        weekDayLab.text = Date().weekdayName

        let calendar = Calendar.init(identifier: .chinese)
        let components = Set<Calendar.Component>([ .month, .day])
        let theComponents = calendar.dateComponents(components, from: Date())

        //TODO:
        let strC1 = theComponents.month?.toString()
        let strC2 = theComponents.day?.toString()
        
        let zhYearStr = (strC1 ?? "-")! + "月" +  (strC2 ?? "-")! + "日"
        zhYearLab.text =  "农历 " + zhYearStr
    }


    func reqNet() {


        let url = "https://baidu.com/"
        var params = [String:String]()

        params["token"] = OUser.getToken()
        params["userId"] = OUser.getUserId()
        

        let jsonData = try? JSON.init(params).rawData()
        var req = try? URLRequest.init(url: url, method: .post)
        req?.httpBody = jsonData

        DlOemHUD.showStatus(title: "登录中...")
        request(req!).responseData { [weak self] (res) in


            DlOemHUD.dismiss()

            if res.result.isSuccess  {

                OUser.setLogin(islogin: true)
                self?.navigationController?.dismiss(animated: true, completion: nil)

            } else {

                DlOemHUD.showError(title: "登录失败")
            }
        }


    }

    func initHandle() {

        //TODO: 暂时屏蔽
        if OClient.isFrinstLaunch() {
            setFirstLaunch()
        }

        // 检测是否登录
        if OUser.isLogin() == false {
            
            guard let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OLoginRootNav") else { return }
            navigationController?.present(vc, animated: true, completion: nil)
            return
        }

        action.bk_(whenTapped: { [weak self] in

            let vc = ONewNoteController()
            self?.navigationController?.pushViewController(vc, animated: true)
        })

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let dataArr = ONoteRealmModel.allObjects()
        let count = UInt(dataArr.count)


        contentList.removeAll()
        for i in 0 ..< count {
            guard let obj = dataArr[i] as? RLMObject else { return }
            contentList.append(obj)
        }

        contentList.reverse()
        tableView.reloadData()
    }


    func setFirstLaunch() {


        let model = ONoteRealmModel()

        model.title = "笔记提示"
        model.uid = OUser.getUserId()
        model.contentText = "小行家Pro是一个简洁优雅的个人日记本，是个人生活点滴的百宝柜。日记本是一种心情，\n希望万两柜能给使用者带来记录心情的美好感觉，让点滴生活串成美丽的珠链。那些珍珠般的点滴生活，保存在万两柜中，尘封其中的美好记忆将历久弥新。"
        model.contentHtml =  "<h1 align=\"center\">日记简介</h1><p style=\"text-indent:0em;margin:4px auto 0px auto;\"><font style=\"font-size:18.000000;color:#000000\">万两柜是一个简洁优雅的个人日记本，是个人生活点滴的百宝柜。日记本是一种心情，希望万两柜能给使用者带来记录心情的美好感觉，让点滴生活串成美丽的珠链。那些珍珠般的点滴生活，保存在万两柜中，尘封其中的美好记忆将历久弥新</font></p>"
        
        model.updateTimeInterval =  Int(Date().timeIntervalSince1970)
        model.timeInterval = Int(Date().timeIntervalSince1970)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        model.dayDateStr = dateFormatter.string(from: Date())
        model.uid = OUser.getUserId()

        let realm = RLMRealm.default()

        realm.beginWriteTransaction()
        realm.add(model)
        try? realm.commitWriteTransaction()

    }
}


extension OHomeViewController:UITableViewDelegate,UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {

        return contentList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 15
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "homecelltitle", for: indexPath) as? OCalenderTitleCell

        cell?.model = contentList[indexPath.section] as? ONoteRealmModel ?? ONoteRealmModel()
        return cell!
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OEditController") as?OEditController else {
                return
        }
        let model = contentList[indexPath.section] as? ONoteRealmModel ?? ONoteRealmModel()
        vc.model = model
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {



            let realm =  RLMRealm.default()

            realm.beginWriteTransaction()
            realm.delete(contentList[indexPath.section])
            try? realm.commitWriteTransaction()


            contentList.remove(at: indexPath.section)

            let range = Range(NSRange.init(location: indexPath.section, length: 1))
            let set = IndexSet(integersIn: range!)

            tableView.deleteSections(set, with: .automatic)
        }
    }
}
