//
//  CMHttpNetworkManager.m
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import "CMHttpNetworkManager.h"
#import "AFNetworking.h"
#import "CMParseDataManager.h"

static  NSString *httpMethods[] = {
    [HttpMethodPOST]             = @"POST",
    [HttpMethodGET]              = @"GET",
    [HttpMethodGETProgress]      = @"GET",
    [HttpMethodHEAD]             = @"HEAD",
    [HttpMethodPOSTForm]         = @"POST",
    [HttpMethodPOSTProgress]     = @"POST",
    [HttpMethodPOSTFormProgress] = @"POST",
    [HttpMethodPUT]              = @"PUT",
    [HttpMethodPATCH]            = @"PATCH",
    [HttpMethodDELETE]           = @"DELETE",
};


@interface CMHttpNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *httpManager; /**< 请求管理器 */

@end

@implementation CMHttpNetworkManager

DEFINE_SINGLETON_T_FOR_CLASS(CMHttpNetworkManager)


-(instancetype)init{
    if (self = [super init]) {
        self.httpManager = [AFHTTPSessionManager manager];
        //申明返回的结果是json类型
        self.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //申明请求的数据是json类型
        self.httpManager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        //如果报接受类型不一致请替换一致text/html或别的
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
        
        
    }
    return self;
}


- (NSURLSessionDataTask *)sendRequestWithUrl:(NSString *)url
                                     msgDict:(NSDictionary *)msgDict
                                  httpMethod:(HttpMethod)httpMethod
                           constructingBlock:(CMConstructingBlock)constructingBlock
                             completionBlock:(CMCompletionBlock)completionBlock{
    
    CMHttpEventInfo *eventInfo = [[CMHttpEventInfo alloc] init];
    if (constructingBlock) {
        constructingBlock(eventInfo);
    }
    return [self sendRequestWithUrl:url msgDict:msgDict eventInfo:eventInfo httpMethod:httpMethod constructingBlock:constructingBlock completionBlock:completionBlock];
}


- (NSURLSessionDataTask *)sendRequestWithUrl:(NSString *)url
                                     msgDict:(NSDictionary *)msgDict
                                   eventInfo:(CMHttpEventInfo *)eventInfo
                                  httpMethod:(HttpMethod)httpMethod
                           constructingBlock:(CMConstructingBlock)constructingBlock
                             completionBlock:(CMCompletionBlock)completionBlock{
    
    if ([self.httpManager.reachabilityManager networkReachabilityStatus] == AFNetworkReachabilityStatusUnknown) {
        NSError *error = [NSError errorWithDomain:@"NSURLErrorNotConnectedToInternet" code:NSURLErrorNotConnectedToInternet userInfo:nil];
        [self handleCallBackWithResponseObject:nil error:error completionBlock:completionBlock];
        return nil;
    }
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.httpManager.requestSerializer requestWithMethod:httpMethods[httpMethod] URLString:[[NSURL URLWithString:url relativeToURL:self.httpManager.baseURL] absoluteString] parameters:msgDict error:&serializationError];
    if (serializationError) {
        [self handleCallBackWithResponseObject:nil error:nil completionBlock:completionBlock];
    }
    @cm_weakify_self
    NSURLSessionDataTask *task = [self.httpManager dataTaskWithRequest:request uploadProgress:eventInfo.uploadProgerssBlock downloadProgress:eventInfo.downloadProgerssBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        @cm_strongify_self
        [self httpRequestEventInfp:eventInfo response:response responseObject:responseObject error:error completionBlock:completionBlock];
    }];
    [task resume];
    return task;
}

- (void)httpRequestEventInfp:(CMHttpEventInfo *)eventInfo
                    response:(NSURLResponse *)response
              responseObject:(id)responseObject
                       error:(NSError *)error
             completionBlock:(CMCompletionBlock)completionBlock{
    if (error) {
         [self handleCallBackWithResponseObject:responseObject error:error completionBlock:completionBlock];
    }else{
        [[CMParseDataManager sharedCMParseDataManager] parseSourceData:responseObject eventInfo:eventInfo completionBlock:completionBlock];
    }
}

/**
 统一处理回调

 @param responseObject 返回数据
 @param error 错误
 @param completionBlock 回调
 */
- (void)handleCallBackWithResponseObject:(id)responseObject
                                   error:(NSError *)error
                         completionBlock:(CMCompletionBlock)completionBlock{
    if ([NSThread isMainThread]) {
        if (completionBlock) {
            completionBlock(responseObject,error);
        }
    }else{
       dispatch_async(dispatch_get_main_queue(), ^{
           if (completionBlock) {
               completionBlock(responseObject,error);
           }
       });
    }
}



@end
