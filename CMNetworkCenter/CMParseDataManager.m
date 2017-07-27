//
//  CMParseDataManager.m
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import "CMParseDataManager.h"
#import "JSONModel.h"

@implementation CMParseDataManager

DEFINE_SINGLETON_T_FOR_CLASS(CMParseDataManager)


static dispatch_queue_t data_parse_operation_processing_queue() {
    static dispatch_queue_t data_parse_operation_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data_parse_operation_processing_queue = dispatch_queue_create("com.cm.data.parsing.operation.queue", DISPATCH_QUEUE_CONCURRENT );
    });
    
    return data_parse_operation_processing_queue;
}

- (void)parseSourceData:(id)sourceData
                toClass:(Class)toClass
   parseCompletionBlock:(CMParsedCompletionBlock)block{
    dispatch_sync(data_parse_operation_processing_queue(), ^{
        NSError *error = nil;
        id completionData = nil;
        if (sourceData && toClass) {
            if ([sourceData isKindOfClass:[NSString class]]) {
                completionData = [[toClass alloc] initWithString:sourceData error:&error];
            }else if ([sourceData isKindOfClass:[NSDictionary class]]){
                completionData = [[toClass alloc] initWithDictionary:sourceData error:&error];
            }else if ([sourceData isKindOfClass:[NSData class]]){
                completionData = [[toClass alloc] initWithData:sourceData error:&error];
            }
        }
        if (block) {
            if (!error && completionData) {
                block(completionData,nil);
            }else{
                block(sourceData,error);
            }
        }
        
    });
}

- (void)parseSourceData:(id)sourceData
              eventInfo:(CMHttpEventInfo *)eventInfo
   completionBlock:(CMCompletionBlock)block{
    [self parseSourceData:sourceData toClass:eventInfo.responseClass parseCompletionBlock:^(id parsedData, NSError *error) {
        if (block) {
            block(parsedData,error);
        }
    }];
}

@end
