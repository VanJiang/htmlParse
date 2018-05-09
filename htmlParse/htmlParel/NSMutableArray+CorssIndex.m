//
//  NSMutableArray+CorssIndex.m
//  lonsdaleiOS
//
//  Created by 寒山 on 16/6/26.
//  Copyright © 2016年 江稳. All rights reserved.
//

#import "NSMutableArray+CorssIndex.h"

@implementation NSMutableArray (CorssIndex)
-(NSObject *)Jr_ObjectAtIndex:(NSInteger)index{
    if([self count]>index){
        return [self objectAtIndex:index];
    }else{
        return nil;
    }
}

@end
