//
//  JRStrUtility.m
//  read
//
//  Created by 江稳 on 13-4-9.
//  Copyright (c) 2013年 江稳. All rights reserved.
//
//#define P   <p>
//#define Ganp </P>
//#define Pstrong <p><strong>
//#define Ganpstrong </p></strong>
//#define  Pa <p><a>
//#define Ganpa </p></a>
#import "JRStrUtility.h"
@implementation JRStrUtility
//去除所有html 标签
+ (NSString*)flattenHTML:(NSString*)html trimWhiteSpace:(BOOL)trim
{

    NSScanner* theScanner = [NSScanner scannerWithString:html];
    NSString* text = nil;
    while ([theScanner isAtEnd] == NO) {

        [theScanner scanUpToString:@"<" intoString:NULL];

        [theScanner scanUpToString:@">" intoString:&text];

        html = [html stringByReplacingOccurrencesOfString:
                         [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}
//去除特定标签
+ (NSString*)flattenHTML2:(NSString*)html trimWhiteSpace:(BOOL)trim string:(NSString*)ht
{
    NSScanner* theScanner = [NSScanner scannerWithString:html];
    NSString* text = nil;
    while ([theScanner isAtEnd] == NO) {

        [theScanner scanUpToString:ht intoString:NULL];

        [theScanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:
                         [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}
+ (NSMutableArray*)parserHtmlcontent:(NSString*)htmlStr
{
    NSMutableArray* sepeciaLabelArr = [NSMutableArray array];
    //去除特殊标签 单标签
    sepeciaLabelArr = [NSMutableArray arrayWithObjects:@"<input", @"<isindex", @"<area", @"<basefont", @"<base", @"<bgsound", @"<col", @"<embed", @"<link", @"<meta", @"<nextid", @"<param", @"<plaintext", @"<spacer", @"<swbr", nil];
    NSMutableString* firstHaddleStr= [NSMutableString stringWithFormat:@"%@", htmlStr];
    
    for (int i = 0; i < [sepeciaLabelArr count]; i++) {
        firstHaddleStr = [NSMutableString stringWithFormat:@"%@", [JRStrUtility flattenHTML2:firstHaddleStr trimWhiteSpace:YES string:[NSString stringWithFormat:@"%@", [sepeciaLabelArr Jr_ObjectAtIndex:i]]]];
    }

    //保留自己需要的标签内容
   NSString* secondHaddleStr = [NSString stringWithFormat:@"%@", firstHaddleStr];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<img" withString:@"[img]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"/>" withString:@"[img]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<p>" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"</p>" withString:@"[p]"];
    
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<li>" withString:@"[p]."];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"</li>" withString:@"[p]"];
    
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<iframe" withString:@"[iframe]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"></iframe>" withString:@"[iframe]"];
   
   
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<a href=\"" withString:@"<a [p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"\">[img]" withString:@"[p][img]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"</a>" withString:@"&&"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<time" withString:@"&&<"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"</time>" withString:@"&&"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<article" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"article\">" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<h2 class=\"h4\"><a" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"</a></h2>" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<time" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"</time>" withString:@"[p]"];
    
    //解析特殊字符 不完全 根据自己情况实际添加
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&#8212;" withString:@"--"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&#8211;" withString:@"-"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&#8221;" withString:@"“"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&middot;" withString:@"•"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&#215;" withString:@"x"];
    secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&rdquo" withString:@"“"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&#038;" withString:@"&"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&#8217" withString:@"'"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"&ccedil" withString:@"ç"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"null" withString:@""];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"[p][p]" withString:@"[p]"];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<br" withString:@""];
   secondHaddleStr = [secondHaddleStr stringByReplacingOccurrencesOfString:@"<hr" withString:@""];
    
   //去除所有没处理的标签
    htmlStr = [NSMutableString stringWithFormat:@"%@", [[[JRStrUtility flattenHTML:secondHaddleStr trimWhiteSpace:YES] stringByReplacingOccurrencesOfString:@"[p][p]" withString:@"[p]"] stringByReplacingOccurrencesOfString:@"<br" withString:@""]];
    
    
    NSMutableArray* fisrstLabelArr = [NSMutableArray arrayWithArray:[htmlStr componentsSeparatedByString:@"[iframe]"]];
    NSMutableArray* secondLabelArr = [NSMutableArray array];
    NSMutableArray* thirdLabelArr = [NSMutableArray array];
    
    //先用图片标记 把得到的数据分割
    for (int i = 0; i < [fisrstLabelArr count]; i++) {
        NSMutableString* parserString = [NSMutableString stringWithFormat:@"%@", [fisrstLabelArr Jr_ObjectAtIndex:i]];
        NSMutableArray* imgHtmlArray = [NSMutableArray arrayWithArray:[parserString componentsSeparatedByString:@"[img]"]];
        [secondLabelArr addObject:imgHtmlArray ];
    }
    //先用文字标记 把得到的数据分割
    for (int i = 0; i < [secondLabelArr count]; i++) {
        NSMutableArray* parserString = (NSMutableArray *)[secondLabelArr Jr_ObjectAtIndex:i];
        for (int j = 0; j < [parserString count]; j++) {
            NSMutableString* imgHtmlArray = [NSMutableString stringWithFormat:@"%@", [parserString Jr_ObjectAtIndex:j]];

            NSMutableArray* pHtmlArray = [NSMutableArray arrayWithArray:[imgHtmlArray componentsSeparatedByString:@"[p]"]];
            [thirdLabelArr addObject:pHtmlArray];
        }
    }
    
    NSMutableArray* fourLabelArr = [NSMutableArray array];
    for (int i = 0; i < [thirdLabelArr count]; i++) {
        NSMutableArray* parserString = (NSMutableArray *)[thirdLabelArr Jr_ObjectAtIndex:i];
        for (int j = 0; j < [parserString count]; j++) {
            NSMutableString* string2 = [NSMutableString stringWithFormat:@"%@", [parserString Jr_ObjectAtIndex:j]];

            [fourLabelArr addObject:string2];
        }
    }
    NSMutableArray* lastLabelArr= [NSMutableArray array];
    //进行文字 图片类的标签模块分类处理
    for (int i = 0; i < [fourLabelArr count]; i++) {
        
        NSMutableString* parserString = [NSMutableString stringWithFormat:@"%@", [fourLabelArr Jr_ObjectAtIndex:i]];
        
        NSRange imageRange = [parserString rangeOfString:@"src="];
        if (imageRange.location == NSNotFound) {
            //文字类
            JRStringModel* stringModel = [[JRStringModel alloc] init];
            
            stringModel.string = [parserString stringByReplacingOccurrencesOfString:@"&&&&" withString:@""];
 
            stringModel.contentType = ContentTypeTextModel;
            if([stringModel.string length]!=0&&![stringModel.string isEqualToString:@"\n\n"]){
                 [lastLabelArr addObject:stringModel];
            }
           
        }
        else {
            //链接类
            NSRange videoRange = [parserString rangeOfString:@"://player"];
            if (videoRange.location != NSNotFound) {
                 //视频类
                JRStringModel* videoModel = [[JRStringModel alloc] init];
                videoModel.contentType = ContentTypeVideoModel;
                NSRange srcRange = [parserString rangeOfString:@"src="];
                NSMutableString* scrString = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:srcRange.location + srcRange.length + 1]];
                NSRange scrLastRange = [scrString rangeOfString:@"\""];
                if(scrLastRange.location!= NSNotFound){
                    NSMutableString* complentSrcRange = [NSMutableString stringWithFormat:@"%@", [scrString substringToIndex:scrLastRange.location]];
                    videoModel.string = complentSrcRange;
                }else{
                    videoModel.string=@"";
                }
                if([videoModel.string length]!=0){
                     [lastLabelArr addObject:videoModel];
                }
            }
            else {
                 //图片 宽高
                JRStringModel* imageModel = [[JRStringModel alloc] init];
                NSRange srcRange = [parserString rangeOfString:@"src="];

                NSMutableString* scrString = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:srcRange.location + srcRange.length + 1]];

                NSMutableString* danyinhao = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:srcRange.location + srcRange.length]];

                danyinhao = [NSMutableString stringWithFormat:@"%@", [danyinhao substringToIndex:1]];

               
                NSRange imgParelRange = [scrString rangeOfString:[NSString stringWithFormat:@"%@", danyinhao]];

                NSMutableString* imgSrcStr = [NSMutableString stringWithFormat:@"%@", [scrString substringToIndex:imgParelRange.location]];

                NSRange widthRange = [parserString rangeOfString:@"width="];
                if (widthRange.location == NSNotFound) {
                    imageModel.width = 673.0;
                }
                else {
                    NSMutableString* widthStr = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:widthRange.location + widthRange.length + 1]];
                    NSMutableString* complentWidthStr = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:widthRange.location + widthRange.length]];
                    complentWidthStr = [NSMutableString stringWithFormat:@"%@", [complentWidthStr substringToIndex:1]];
                    NSRange hasStrRange = [widthStr rangeOfString:[NSString stringWithFormat:@"%@", complentWidthStr]];
                    NSMutableString* hasWidthStr = [NSMutableString stringWithFormat:@"%@", [widthStr substringToIndex:hasStrRange.location]];
                    if( ![JRStrUtility isAllNum:hasWidthStr])
                    {
                         imageModel.width =600;
                    }else{
                         imageModel.width = [hasWidthStr floatValue];
                    }
                   
                }

                NSRange heightRange = [parserString rangeOfString:@"height="];
                if (heightRange.location == NSNotFound) {
                    imageModel.heigth = 800;
                }
                else {
                    NSMutableString* heightStr  = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:heightRange.location + heightRange.length + 1]];

                    NSMutableString* complentHeightStr = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:heightRange.location + heightRange.length]];
                    
                    complentHeightStr = [NSMutableString stringWithFormat:@"%@", [complentHeightStr substringToIndex:1]];
                    NSRange  hasHeightStrRange = [heightStr rangeOfString:[NSString stringWithFormat:@"%@", complentHeightStr]];
                    NSMutableString* hasHeightStr = [NSMutableString stringWithFormat:@"%@", [heightStr substringToIndex:hasHeightStrRange.location]];
                    if( (![JRStrUtility isAllNum:hasHeightStr]))
                    {
                         imageModel.heigth =800;
                    }else{
                        imageModel.heigth = [hasHeightStr floatValue];
                    }
                }
                NSRange descRange = [parserString rangeOfString:@"alt="];
                if (descRange .location == NSNotFound) {
                    imageModel.imagedec = @"";
                }
                else {
                    NSMutableString* descStr = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:descRange .location + descRange .length + 1]];
                    NSMutableString* complentDescStr = [NSMutableString stringWithFormat:@"%@", [parserString substringFromIndex:descRange .location + descRange .length]];
                    complentDescStr = [NSMutableString stringWithFormat:@"%@", [complentDescStr substringToIndex:1]];
                    NSRange hasDescStrRange = [descStr rangeOfString:[NSString stringWithFormat:@"%@", complentDescStr]];
                    NSMutableString* hasDescStr = [NSMutableString stringWithFormat:@"%@", [descStr substringToIndex:hasDescStrRange.location]];
                    imageModel.imagedec = hasDescStr;
                }
                imageModel.contentType = ContentTypeImageModel;
                imageModel.string = imgSrcStr;
                if([imgSrcStr length]!=0&&[imgSrcStr rangeOfString:@"http"].location!=NSNotFound){
                    [lastLabelArr addObject:imageModel];
                }
            
            }
        }
    }
    return lastLabelArr;
}
+ (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
@end
