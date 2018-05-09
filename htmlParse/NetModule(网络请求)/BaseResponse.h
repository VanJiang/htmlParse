//
//  BaseResponse.h
//  Quanner
//
//  Created by rogers on 15/10/22.
//  Copyright © 2015年 juexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface BaseResponse : BaseModel
@property(assign,nonatomic)int code;
@property(copy,nonatomic)NSString *msg;
@property(assign,nonatomic)int isSuccess;
@property(strong,nonatomic)id data;
@property(copy,nonatomic)NSString *cmd;
@end
