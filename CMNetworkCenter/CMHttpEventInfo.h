//
//  CMHttpEventInfo.h
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CMHttpEventInfo;


/**
 发送请求的时候修改eventInfo的block

 */
typedef void (^CMConstructingBlock)(CMHttpEventInfo *eventInfo);

/**
 当数据返回以后的回调block

 */
typedef void (^CMCompletionBlock)(id responseData, NSError *error);

/**
 *  网络结束时回调
 *
 *  @param responseData 返回获取到的数据，如果json数据，返回json或者自动解析后的对象，其它的直接返回原始数据（比如：nsdata）
 *  @param error        如果发生错误，则返回error
 *  @param response     http url加载响应response，包含返回网络状态及错误信息
 */
typedef void (^CMCompletionWithResponseBlock)(id responseData, NSError *error, NSURLResponse *response);

typedef  void (^CMUploadProgressBlock) (NSProgress *uploadProgress);

typedef  void (^CMDownloadProgerssBlock) (NSProgress *downloadProgress);


@interface CMHttpEventInfo : NSObject

@property (nonatomic, copy) CMUploadProgressBlock uploadProgerssBlock; /**< 上传回调 */

@property (nonatomic, copy) CMDownloadProgerssBlock downloadProgerssBlock; /**< 下载回调 */

@property (nonatomic) Class responseClass;  /**< 要返回的数据模型 */

@end
