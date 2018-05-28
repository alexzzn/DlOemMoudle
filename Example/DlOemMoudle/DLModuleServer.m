//
//  DLModuleProtocol.m
//  DlOemMoudle_Example
//
//  Created by ZZN on 2018/5/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import <BeeHive/BHServiceManager.h>
#import "DLModuleServer.h"
#import "Header.h"



//// 宏注册
//@BeeHiveMod(DLModuleProtocol)
//@interface DLModuleServer()
//
//@end


@implementation DLModuleServer
    
 
+ (void)load {
 
    [self setUp];
}
// api 注册
+ (void) setUp {
    
    [[BHServiceManager sharedManager] registerService:@protocol(DLModuleProtocol) implClass:[DLModuleServer class]];
}
   
-(void)setBackColor:(UIColor *)color {
    
    UIViewController *vc = [[[UIApplication sharedApplication].windows firstObject] rootViewController];
    vc.view.backgroundColor = color;
}
    
@end
