//
//  JRStrUtility.h
//  read
//
//  Created by 江稳 on 13-4-9.
//  Copyright (c) 2013年 江稳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRStringModel.h"
#import "NSMutableArray+CorssIndex.h"
@interface JRStrUtility : NSObject
+ (NSMutableArray*)parserHtmlcontent:(NSString*)string;
+ (NSString*)flattenHTML:(NSString*)html trimWhiteSpace:(BOOL)trim;
+ (NSString*)flattenHTML2:(NSString*)html trimWhiteSpace:(BOOL)trim string:(NSString*)ht;


@end
