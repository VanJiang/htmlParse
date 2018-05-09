//
//  BaseRequestClient.h
//  Quanner
//
//  Created by rogers on 15/10/22.
//  Copyright © 2015年 juexin. All rights reserved.
//
#define REQUEST_CALLBACK void (^)(BaseResponse *response,NSError *error)
#import "AFHTTPSessionManager.h"
#import "BaseRquestParams.h"
#import "BaseResponse.h"
#import "URLPath.h"
@interface BaseRequestClient : AFHTTPSessionManager

+ (void)baseGetRequest:(BaseRquestParams*)params block:(REQUEST_CALLBACK)block;
+ (void)basePostRequest:(BaseRquestParams*)params block:(REQUEST_CALLBACK)block;
+ (void)uploadImageArray:(BaseRquestParams*)params imageArray:(NSMutableArray*)imageArray block:(REQUEST_CALLBACK)block;
+ (void)uploadImage:(BaseRquestParams*)params image:(UIImage*)image block:(REQUEST_CALLBACK)block;
+ (void)cancelAllRequest;
@end
