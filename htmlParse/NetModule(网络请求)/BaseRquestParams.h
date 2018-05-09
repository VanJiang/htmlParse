//
//  BaseRquestParams.h
//  ProjectTemplate
//
//  Created by rogers on 15/10/21.
//  Copyright © 2015年 江稳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRquestParams : NSObject
@property(strong,nonatomic)id requestModel;
@property(strong,nonatomic)NSDictionary*requestParamsDic;
@property(strong,nonatomic)NSString*requestURL;
@end
