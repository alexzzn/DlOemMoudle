//
//  Header.h
//  DlOemMoudle_Example
//
//  Created by ZZN on 2018/5/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#ifndef Header_h
#define Header_h


// 马甲服务
@protocol DLModuleProtocol<BHModuleProtocol>
    
@property(nonatomic, strong) NSString *phoneNo;
    
    
-(void) setBackColor:(UIColor *)color;
    
    
@end


#endif /* Header_h */
