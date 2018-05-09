//
//  OSearchController.swift
//  YPHua
//
//  Created by ZZN on 2017/10/31.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

import UIKit
import RxCocoa
import Realm

class OSearchController: UITableViewController {

    var searchBar:UISearchBar?
    var modelList = [RLMObject]()

    var searchDesc:String? {

        didSet {

            searchWithDB()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 108
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground

    }




    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        searchBar = UISearchBar()
        navigationItem.titleView = searchBar

        searchBar?.showsCancelButton = false
        searchBar?.becomeFirstResponder()

        searchBar?.barTintColor = UIColor.groupTableViewBackground
        searchBar?.delegate = self

        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true


        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancel))

    }


    @objc func cancel() {

        navigationController?.popViewController(animated: true)
    }

    func searchWithDB() {


        modelList.removeAll()
        let preText = self.searchDesc ?? ""

        let pre = NSPredicate.init(format: "contentText CONTAINS %@", preText)
        let list = ONoteRealmModel.objects(with: pre)

        for i in 0..<UInt(list.count) {
            modelList.append(list[i] as! RLMObject)
        }
        modelList.reverse()

        OperationQueue.main.addOperation { [weak self] in
            self?.tableView.reloadData()
        }

    }


    // 逻辑处理
    func initHandle() {

    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return modelList.count
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? OCalenderSubCell else { return UITableViewCell() }

        cell.model = modelList[indexPath.row] as? ONoteRealmModel ?? ONoteRealmModel()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let vc = OCommon.getDlOemStory()?.instantiateViewController(withIdentifier: "OEditController") as?OEditController
        let model = modelList[indexPath.row] as? ONoteRealmModel ?? ONoteRealmModel()
        vc?.model = model
        navigationController?.pushViewController(vc!, animated: true)
        

    }
}

extension OSearchController:UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating {

    // 更新设置
    func updateSearchResults(for searchController: UISearchController) {

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {

        self.searchDesc = searchText
    }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        searchBar.resignFirstResponder()
//        navigationController?.popViewController(animated: true)
//    }
}
