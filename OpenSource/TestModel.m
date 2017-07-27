//
//  TestModel.m
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

/** 默认所有的属性都是Optional  */
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end


@implementation TestData

/** 默认所有的属性都是Optional  */
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end

@implementation TestModelItem
/** 默认所有的属性都是Optional  */
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end
