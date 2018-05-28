//
//  ViewController.swift
//  DlOemMoudle
//
//  Created by ZZN on 05/08/2018.
//  Copyright (c) 2018 ZZN. All rights reserved.
//

import UIKit
import BeeHive

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let v = BeeHive.shareInstance().createService(DLModuleProtocol.self) as? DLModuleServer
        v?.setBack(UIColor.red)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

