//
//  OClient.swift
//  DlOemMoudle
//
//  Created by ZZN on 2018/5/11.
//

import UIKit

//缓存app版本连接 类型
let APPNETTYPEKEY         = "APPNETTYPEKEY"
//缓存app版本key
let APPVERSIONKEY        = "APPVERSIONKEY"
//缓存app版本是否第一次启动
let APPFRISTLAUNCHKEY    = "APPFRISTLAUNCHKEY"
//缓存app是否登陆
let USERISLOGIN          = "USERISLOGIN"


class OClient: NSObject {
    
    /** 客服端-管理类-实例方法 */
    
    
    //是否第一次启动
    class func isFrinstLaunch() ->Bool {
        
        if !UserDefaults.standard.bool(forKey: APPFRISTLAUNCHKEY) {
            
            UserDefaults.standard.set(true, forKey: APPFRISTLAUNCHKEY)
            return true
        }
        return false
    }
    
    //客服端 版本号
    class func clientVersion() -> String {
        
        guard let appV:String = getAppInfoDict()["CFBundleShortVersionString"] as? String else { return "0"}
        return appV
    }
    
    //appinfo 集合
    class func getAppInfoDict() -> [String:Any]{
        
        guard let infoDict = Bundle.main.infoDictionary else { return ["":""]}
        return infoDict
    }
    // 获取appurlscheme
    class func getAppUrlScheme() -> String {
        
        let typesArr = getAppInfoDict()["CFBundleURLTypes"] as? Array<NSDictionary>
        let schemeStr = typesArr?.first?["CFBundleURLName"] as? String
        return schemeStr ?? ""
    }
    
    
    
}
