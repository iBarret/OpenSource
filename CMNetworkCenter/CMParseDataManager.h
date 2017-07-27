//
//  CMParseDataManager.h
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "CMHttpEventInfo.h"
typedef void (^CMParsedCompletionBlock)(id parsedData, NSError *error);
@interface CMParseDataManager : NSObject

DEFINE_SINGLETON_T_FOR_HEADER(CMParseDataManager)

/**
 数据自动解析

 @param sourceData 解析数据源
 @param toClass 解析成的对象class
 @param block 解析成功回调
 */
- (void)parseSourceData:(id)sourceData
                toClass:(Class)toClass
   parseCompletionBlock:(CMParsedCompletionBlock)block;


/**
 数据自动解析
 
 @param sourceData 解析数据源
 @param eventInfo 解析成的对象class
 @param block 解析成功回调
 */
- (void)parseSourceData:(id)sourceData
                eventInfo:(CMHttpEventInfo *)eventInfo
   completionBlock:(CMCompletionBlock)block;

@end
