//
//  ODetailsController.swift
//  YPHua
//
//  Created by ZZN on 2017/11/1.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import SnapKit

class ODetailsController: UIViewController {


    var model:ONoteRealmModel?
    
    @IBOutlet weak var headV: ODetailsControllerHeaderV!
    @IBOutlet weak var contentV: UIView!
    var textV:UITextView!
    var htmlStr:String?

    var editViewControl:OEditController?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)




    }

    func initView() {


        textV = UITextView()
        textV.isEditable = false

        let html = htmlStr ?? ""

        let data = html.data(using: String.Encoding.utf8) ?? Data()
        
        
        //let attr = try? NSAttributedString(data: data, options: [NSDocumentTypeDocumentOption:NSHTMLTextDocumentType,NSCharacterEncodingDocumentOption:String.Encoding.utf8.rawValue,kCTKernAttributeName:6], documentAttributes: nil)
        
        
        
        let dics = [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:String.Encoding.utf8] as [NSAttributedString.DocumentReadingOptionKey : Any]
        let attr =   try? NSAttributedString.init(data: data, options: dics, documentAttributes: nil)
        textV.attributedText = attr

        contentV.addSubview(textV)
        textV.snp.makeConstraints { (make) in

            make.edges.equalTo(0)
        }


    }

}

// 飞猪时代
class ODetailsControllerHeaderV:UIView {

}
