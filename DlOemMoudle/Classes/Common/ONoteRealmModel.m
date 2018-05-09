//
//  ONoteRealmModel.m
//  YPHua
//
//  Created by ZZN on 2017/11/3.
//  Copyright © 2017年 zhaofanjinrong.com. All rights reserved.
//

#import "ONoteRealmModel.h"

@implementation ONoteRealmModel


///// Dic -> model
//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//
//    NSNumber *intId = dic[@"timeInter"];
//    self.custId = [NSString stringWithFormat:@"%@",intId];
//    return YES;
//}
//
///// model -> Dic
//- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
//
//    //    dic[@"t"] = @([self.time timeIntervalSince1970] * 1000).description;
//    dic[@"custId"] = [[NSNumber alloc] initWithFloat:self.custId.floatValue];
//    return YES;
//}


+(NSString *)primaryKey {
    return @"timeInterval";
}

@end
