//
//  BaseModel.m
//  DDYueSao
//
//  Created by 许宏彬 on 15/12/8.
//  Copyright © 2015年 x. All rights reserved.
//

#import "BaseModel.h"
@implementation BaseModel
- (instancetype)initWithJSONDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if (![dict isKindOfClass:[NSNull class]]) {
            [self reflectDataFromOtherObject:dict];
//            [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                if (obj != [NSNull null]) {
//                    if ([obj isKindOfClass:[NSString class]]) {
//                        NSString * objStr=(NSString *)obj;
//                        if (objStr.length==0) {
//                            [self setValue:objStr forKey:key];
//                        }
//                        else
//                        {
//                            [self setValue:obj forKey:key];
// 
//                        }
//                    }
//                    else
//                    {
//                        [self setValue:obj forKey:key];
// 
//                    }
//                }
//                else
//                {
//                    [self setValue:@"" forKey:key];
//                }
//            }];
        }
    }
    return self;
}

@end
