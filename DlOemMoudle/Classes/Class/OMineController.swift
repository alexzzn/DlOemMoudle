//
//  OMineController.swift
//  YPHua
//
//  Created by ZZN on 2017/10/31.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit

class OMineController: UITableViewController {


    var titleArr = ["日历","关于我们","意见反馈","退出登录"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return titleArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ominecell", for: indexPath)

        cell.textLabel?.text = titleArr[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.darkGray

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {

        case 0:
            
            let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OCalendarController") as?OCalendarController
            navigationController?.pushViewController(vc!, animated: true)

        case 1:

            let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OAboutMeController") as?OAboutMeController
            navigationController?.pushViewController(vc!, animated: true)
        case 2:

            
            let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OFeedBackVC") as?OFeedBackVC
            navigationController?.pushViewController(vc!, animated: true)
        case 3:


            DlOemHUD.showAlert(content: "是否退出登录", trueTitle: "是", cancelTitle: "否", trueCol: {


                DlOemHUD.showStatus(title: "退出中")
                Timer.bk_scheduledTimer(withTimeInterval: 1.5, block: { [weak self] (timer) in


                    DlOemHUD.dismiss()
                    guard let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OLoginRootNav") else { return }
                    
                    OUser.setLogin(islogin: false)
                    OUser.setToken(text: "")

                    self?.navigationController?.present(vc, animated: true, completion: nil)

                }, repeats: false)


            }, cancelCol: {

            })




        default:
            break
        }
    }
}
