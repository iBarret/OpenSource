//
//  CMHttpNetworkManager.h
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#import "CMHttpEventInfo.h"

/** http请求方式 */
typedef NS_ENUM(NSInteger, HttpMethod) {
    HttpMethodPOST,
    HttpMethodGET,
    HttpMethodGETProgress,
    HttpMethodHEAD,
    HttpMethodPOSTForm,
    HttpMethodPOSTProgress,
    HttpMethodPOSTFormProgress,
    HttpMethodPUT,
    HttpMethodPATCH,
    HttpMethodDELETE,
};

@interface CMHttpNetworkManager : NSObject

DEFINE_SINGLETON_T_FOR_HEADER(CMHttpNetworkManager)

/**
 *  创建默认的requestEvent用于发送请求，可以传入快捷参数，通过constructingBlock可以修改
 *
 *  @param url               请求完整的url
 *  @param msgDict           post对应的参数
 *  @param httpMethod        httpMethod
 *  @param constructingBlock 抛出默认创建的requestEvent，用于修改参数
 *  @param completionBlock   联网回调
 *
 *  @return 本次请求的task，可以用于取消联网(如果不存在，返回nil)
 */
- (NSURLSessionDataTask *)sendRequestWithUrl:(NSString *)url
                                     msgDict:(NSDictionary *)msgDict
                                  httpMethod:(HttpMethod)httpMethod
                           constructingBlock:(CMConstructingBlock)constructingBlock
                             completionBlock:(CMCompletionBlock)completionBlock;


@end
