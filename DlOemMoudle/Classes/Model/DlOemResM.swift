//
//  DlOemResM.swift
//  DlOemMoudle_Example
//
//  Created by ZZN on 2018/5/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import YYModel

class DlOemResCommonM: NSObject {

    // 状态
    var status:NSNumber?
    // 提示信息
    var message:String?
    // 请求内容
    var body:AnyObject?
}

class DlOemUserInfoM:NSObject {
    
    
    // 提示信息
    var message:String?
    // 客户ID
    var custId:NSNumber?
    // 手机号
    var phoneNo:NSString?
    // 头像
    var headimgUrl:NSString?
    // 身份证号
    var custNumber:NSString?
    // 客户实名
    var custName:NSString?
    // 银行卡名称
    var bankName:NSString?
    // 银行卡号
    var cardNumber:NSString?
    // 认证状态
    var status:NSNumber?
    // 各个认证模块 是否有 1 失效
    var oldStatus:NSNumber?
    // 是否为黑名单中客户 1 true   0 false
    var isBlack:NSNumber?
    // 接口编号
    var interId:NSNumber?
    // 商户编号
    var companyId:NSNumber?
    // 代理商ID
    var agentId:NSNumber?
    // 上级代理商ID
    var fagentId:NSNumber?
    // token
    var token:NSString?
    // 活动ID
    var actId:NSString?
    // 活动封面图
    var coverImg:NSString?
    
    // 升级文件所在地址
    var updateUrl:NSString?
    // 升级内容
    var updateNote:NSString?
    // 最新版本
    var appVersion:NSString?
    // 是否需要升级  0否 1可选升级 2必须升级
    var needUpdate:NSNumber?
    // 公司电话号码
    var serverPhone:NSString?
    // 公司电话号码
    var copyRight:NSString?
    // 配置开关
    var oemUISwitchStatus:NSNumber?
    
    // 获取类中params参数
    func paramsCopy() -> NSDictionary {
        
        return self.yy_modelToJSONObject() as? NSDictionary ?? NSDictionary()
    }
}

