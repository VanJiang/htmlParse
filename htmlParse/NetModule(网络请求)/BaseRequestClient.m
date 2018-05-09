//
//  BaseRequestClient.m
//  Quanner
//
//  Created by rogers on 15/10/22.
//  Copyright © 2015年 juexin. All rights reserved.
//

#import "BaseRequestClient.h"
#import "NSDictionary+SMC.h"
#import "MJExtension.h"
#import "AppDelegate.h"
#define DF_app AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
#define UDF_default NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]
@implementation BaseRequestClient
+ (instancetype)sharedClient {
    static BaseRequestClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BaseRequestClient alloc] init];
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript" , @"text/plain" ,@"text/html", nil];
        
    });
    
    return _sharedClient;
}
+ (void)baseGetRequest:(BaseRquestParams*)params block:(REQUEST_CALLBACK)block{
//    UDF_default;
//    if([defaults objectForKey:USER_TOKEN]){
//        [[BaseRequestClient sharedClient].requestSerializer setValue:[defaults objectForKey:USER_TOKEN] forHTTPHeaderField:@"Authorization"];
//    }else{
        [[BaseRequestClient sharedClient].requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
  //  }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[BaseRequestClient sharedClient] GET:[NSString stringWithFormat:@"%@%@",API_ROOT,params.requestURL] parameters:params.requestParamsDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(responseObject!=nil){
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]options: NSJSONReadingMutableContainers error: &error];
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:jsonDic];
             if(response.code!= 200){
//                DF_app
//                 //[app showErrowMsgView:response.msg];
             }else{
                if(params.requestModel){
                    if([jsonDic[@"data"] isKindOfClass:[NSArray class]]){
                        response.data = [params.requestModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
                    }else{
                        response.data = [params.requestModel mj_objectWithKeyValues:jsonDic[@"data"]];
                    }
                }else{
                    response.data = jsonDic[@"data"];
                }
                block(response,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        DF_app
        ////[app showErrowMsgView:@"连接服务失败"];
        block(nil,error);
    }];
}

+ (void)basePostRequest:(BaseRquestParams*)params block:(REQUEST_CALLBACK)block{
    UDF_default;
//    if([defaults objectForKey:USER_TOKEN]){
//        [[BaseRequestClient sharedClient].requestSerializer setValue:[defaults objectForKey:USER_TOKEN] forHTTPHeaderField:@"Authorization"];
//    }else{
         [[BaseRequestClient sharedClient].requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
   // }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[BaseRequestClient sharedClient] POST:[NSString stringWithFormat:@"%@%@",API_ROOT,params.requestURL] parameters:params.requestParamsDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull operation, id  _Nonnull responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(responseObject!=nil){
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]options: NSJSONReadingMutableContainers error: &error];
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:jsonDic];
            if(response.code!= 1){
               // DF_app
                 //[app showErrowMsgView:response.msg];
                block(response,nil);
            }else{
                if(params.requestModel){
                    if([jsonDic[@"data"] isKindOfClass:[NSArray class]]){
                        response.data = [params.requestModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
                    }else{
                        response.data = [params.requestModel mj_objectWithKeyValues:jsonDic[@"data"]];
                    }
                }else{
                    response.data = jsonDic[@"data"];
                }
                block(response,nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nonnull operation, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //DF_app
         //[app showErrowMsgView:@"连接服务失败"];
        block(nil,error);
    }];
}

+ (void)uploadImageArray:(BaseRquestParams*)params imageArray:(NSMutableArray*)imageArray block:(REQUEST_CALLBACK)block{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [BaseRequestClient sharedClient];
    [manager POST:[NSString stringWithFormat:@"%@%@",API_ROOT,params.requestURL] parameters:params.requestParamsDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for(int i=0;i<imageArray.count-1;i++){
            NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.4);
            NSString *str = [NSString stringWithFormat:@"%0.0f",[[NSDate date] timeIntervalSince1970]*1000];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            // 上传图片，以文件流的格式
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(responseObject!=nil){
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]options: NSJSONReadingMutableContainers error: &error];
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:jsonDic];
            if(response.code == 1){
                if(params.requestModel){
                    if([jsonDic[@"data"] isKindOfClass:[NSArray class]]){
                        response.data = [params.requestModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
                    }else{
                        response.data = [params.requestModel mj_objectWithKeyValues:jsonDic[@"data"]];
                    }
                }else{
                    response.data = jsonDic[@"data"];
                }
                block(response,nil);
               
            }else{
                DF_app
                 //[app showErrowMsgView:response.msg];
                //                [app startLogin];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (block) {
            block(nil,error);
        }
    }];
}
+ (void)uploadImage:(BaseRquestParams*)params image:(UIImage*)image block:(REQUEST_CALLBACK)block{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [BaseRequestClient sharedClient];
    [manager POST:[NSString stringWithFormat:@"%@%@",API_ROOT,params.requestURL] parameters:params.requestParamsDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
        NSString *str = [NSString stringWithFormat:@"%0.0f",[[NSDate date] timeIntervalSince1970]*1000];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(responseObject!=nil){
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]options: NSJSONReadingMutableContainers error: &error];
            BaseResponse *response = [BaseResponse mj_objectWithKeyValues:jsonDic];
            if(response.code == 1){
                if(params.requestModel){
                    if([jsonDic[@"data"] isKindOfClass:[NSArray class]]){
                        response.data = [params.requestModel mj_objectArrayWithKeyValuesArray:jsonDic[@"data"]];
                    }else{
                        response.data = [params.requestModel mj_objectWithKeyValues:jsonDic[@"data"]];
                    }
                }else{
                    response.data = jsonDic[@"data"];
                }
                block(response,nil);
              
            }else{
                DF_app
                 //[app showErrowMsgView:response.msg];
                //                [app startLogin];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (block) {
            block(nil,error);
        }
    }];
}

+ (void)cancelAllRequest {
    [[BaseRequestClient sharedClient].operationQueue cancelAllOperations];
}
@end
