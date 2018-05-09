//
//  JRStringModel.h
//  read
//
//  Created by 江稳 on 13-4-17.
//  Copyright (c) 2013年 江稳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
enum ContentTypeModel{
    ContentTypeTextModel = 1,
    ContentTypeImageModel =2,
    ContentTypeVideoModel =3
};
@interface JRStringModel : NSObject
@property (nonatomic, assign) int image;
@property (nonatomic, assign) BOOL changeline;
@property (nonatomic, assign) NSInteger fontsize;
@property (nonatomic, assign) BOOL needblod;
 
@property (nonatomic, retain) UIImage* tureimage;
@property (nonatomic, retain) NSData* imagedata;
@property (nonatomic, copy) NSMutableString* collectstringmodel;


@property (nonatomic, assign) enum ContentTypeModel contentType;
@property (nonatomic, copy) NSString* string;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat heigth;
@property (nonatomic, copy) NSString* imagedec;

@end
