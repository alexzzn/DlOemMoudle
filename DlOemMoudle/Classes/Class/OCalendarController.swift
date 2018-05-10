//
//  OCalendarController.swift
//  YPHua
//
//  Created by ZZN on 2017/11/3.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import FSCalendar

class OCalendarController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    var dateFormatter:DateFormatter?
    var dateSelection:Array<String>?
    var modelList = [RLMObject]()
    var searchDesc:String?
    var notiLab:UILabel?

    var selectDate:String? {

        didSet {

            self.searchWithDB()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTheme()
    }
    
    func initTheme() {



        tableView.rowHeight = 90
        tableView.tableFooterView = UIView()


        
        calendarView.appearance.headerTitleColor = UIColor.colorWithHexString(hexColor: "#666666 ", alapha: 1)
        calendarView.appearance.weekdayTextColor = UIColor.colorWithHexString(hexColor: "#666666 ", alapha: 1)
        calendarView.appearance.selectionColor =  UIColor.colorWithHexString(hexColor: "#FEA022", alapha: 1)
        calendarView.appearance.todayColor = UIColor.gray
        calendarView.appearance.titleDefaultColor = UIColor.darkGray



        calendarView.delegate = self
        calendarView.dataSource = self


        let location = Locale(identifier: "zh-CN")
        dateFormatter = DateFormatter()
        dateFormatter?.locale = location
        dateFormatter?.dateFormat = "yyyy-MM-dd"


        let obj = ONoteRealmModel.allObjects()
        var arr = [RLMObject]()
        for i in 0..<UInt(obj.count) {
            
            guard let v = obj.object(at: i) as?RLMObject else { return }
            arr.append(v)
        }

        let seldataList = arr.flatMap { (value) -> String? in

            guard let model = value as? ONoteRealmModel else { return nil }
            return model.dayDateStr
        }
        dateSelection = seldataList
        selectDate = dateFormatter?.string(from: calendarView.calculator.calendar.today ?? Date())
    }


    func searchWithDB() {


        modelList.removeAll()
        let preText = self.selectDate ?? ""

        let pre = NSPredicate(format: "dayDateStr == %@", preText)
        let list = ONoteRealmModel.objects(with: pre)

        for i in 0..<UInt(list.count) {
            
            guard let v = list.object(at: i) as?RLMObject else { return }
            modelList.append(v)
        }
        modelList.reverse()

        OperationQueue.main.addOperation { [weak self] in
            self?.tableView.reloadData()
        }

        //
        if modelList.count == 0 {
            notiLab?.removeFromSuperview()
            
            notiLab = UILabel.intiWith(title: "当天没有日记标签", titleFont: UIFont.systemFont(ofSize: 16), titleColor: UIColor.darkGray, bgColor: nil)
            notiLab?.textAlignment = .center
            
            //notiLab?.frame = CGRect.init(x: 0, y: 400, width: DlOemFrame.Screen.Width, height: 50)
            view.addSubview(notiLab!)
            notiLab?.snp.makeConstraints({ (make) in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(calendarView.snp.bottom).offset(20)
            })

        } else {

            notiLab?.isHidden = true
            notiLab?.removeFromSuperview()
        }
        
    }
}

// tableview 代理
extension OCalendarController:UITableViewDataSource,UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return modelList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as? OCalenderSubCell
        cell?.model = modelList[indexPath.row] as? ONoteRealmModel ?? ONoteRealmModel()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //let vc = R.storyboard.oController.oEditController()
        
        let story = OCommon.getDlOemStory()
        let vc = story?.instantiateViewController(withIdentifier: "OEditController") as? OEditController
        let model = modelList[indexPath.row] as? ONoteRealmModel ?? ONoteRealmModel()
        vc?.model = model
        navigationController?.pushViewController(vc!, animated: true)
    }


    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {



            let realm = RLMRealm.default()

            realm.beginWriteTransaction()
            realm.delete(modelList[indexPath.row])
            try? realm.commitWriteTransaction()


            modelList.remove(at: indexPath.row)
            let range = Range(NSRange.init(location: indexPath.row, length: 1))
            let set = IndexSet(integersIn: range!)

//            tableView.deleteSections(set, with: .automatic)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }

}

extension OCalendarController:FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance {


    // 日历事件
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {


        let dataStr = dateFormatter?.string(from: date) ?? ""
        if dateSelection?.contains(dataStr) == true {

            return 1
        } else {

            return 0
        }
    }

    // 日历选择
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        let dateStr = dateFormatter?.string(from: date) ?? ""
        self.selectDate = dateStr
    }
}
