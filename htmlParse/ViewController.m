//
//  ViewController.m
//  htmlParse
//
//  Created by 寒山 on 2018/5/9.
//  Copyright © 2018年 江稳. All rights reserved.
//

#import "ViewController.h"
#import "JRStrUtility.h"
#import "BaseRequestClient.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllContentDetailInfo];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark 获取文章详情
-(void)getAllContentDetailInfo{
//    DF_app;
//    [app showRefreshMsgView];
    BaseRquestParams *params = [[BaseRquestParams alloc]init];
    params.requestURL = @"/details?id=287";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    params.requestParamsDic = dic;
    params.requestModel =nil;
    [BaseRequestClient baseGetRequest:params block:^(BaseResponse *response, NSError *error) {
        if(!error){
            if(response.code==200){
                [self getConetentDetail:response.data[@"contests"]];
            }
        }
    }];
    
}
-(void)getConetentDetail:(NSString *)contentString{
    //获取文章内容
    NSMutableArray* contentDtailArray = [NSMutableArray arrayWithArray:[JRStrUtility parserHtmlcontent:contentString]];
    
    for (int i=0; i<contentDtailArray.count; i++) {
        JRStringModel* stringModel = (JRStringModel*)[contentDtailArray Jr_ObjectAtIndex:i];
        NSLog(@"%@",stringModel.string);
    }
    
    // [contentableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
