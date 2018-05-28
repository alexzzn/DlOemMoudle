//
//  DLModuleProtocol.h
//  DlOemMoudle_Example
//
//  Created by ZZN on 2018/5/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BeeHive/BeeHive.h>
#import "Header.h"



@interface DLModuleServer : NSObject<BHModuleProtocol,DLModuleProtocol>

@end

