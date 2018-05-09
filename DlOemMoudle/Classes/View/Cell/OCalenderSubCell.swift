//
//  OCalenderSubCell.swift
//  YPHua
//
//  Created by ZZN on 2017/11/3.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import SwiftDate

class OCalenderSubCell: UITableViewCell {

    var model = ONoteRealmModel() {



        didSet {
            initData()
        }
    }

    @IBOutlet weak var dayLab: UILabel!
    @IBOutlet weak var yearLab: UILabel!
    @IBOutlet weak var contentV: UITextView!
    @IBOutlet weak var leftV: UIImageView!


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func initData() {

        if model.timeInterval == nil {
            return
        }

        let timeInterval = model.timeInterval//TimeInterval(model.createtime as String )
        let data = Date.init(timeIntervalSince1970: TimeInterval(timeInterval))


        dayLab.text = data.day.toString() + " / " + data.weekdayName
        yearLab.text = data.year.toString() + "." + data.monthName

        contentV.attributedText = model.contentText.toAttr(lineH: 2, font: UIFont.systemFont(ofSize: 12))
//        contentV.text = model.contentText
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
