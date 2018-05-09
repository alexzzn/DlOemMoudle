//
//  ONoteRealmModel.h
//  YPHua
//
//  Created by ZZN on 2017/11/3.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>


@interface ONoteRealmModel : RLMObject


// 创建时间戳
@property  NSInteger  timeInterval;
// 更新时间戳
@property  NSInteger  updateTimeInterval;
// 年月日
@property  NSString  *dayDateStr;
// 标题
@property  NSString  *title;
// 文本
@property  NSString  *contentText;
// html5文本
@property  NSString  *contentHtml;
// logo
@property  NSString  *logo;




//// logo
//@property (nonatomic, strong) NSString  * phoneNo;

//// 手机号
//@property (nonatomic, strong) NSString  * phoneNo;
//// 头像
//@property (nonatomic, strong) NSString  * headimgUrl;
//// 身份证号
//@property (nonatomic, strong) NSString  * custNumber;
//// 客户实名
//@property (nonatomic, strong) NSString  * custName;
//// 认证状态
//@property (nonatomic, assign) NSInteger  status;
//// 各个认证模块 是否有 1 失效
//@property (nonatomic, assign) NSInteger  oldStatus;



@end
