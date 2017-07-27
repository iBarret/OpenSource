//
//  TestModel.h
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import "JSONModel.h"

@protocol TestModelItem;
@class TestData;

@interface TestModel : JSONModel

@property (nonatomic, assign) long status;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, strong) TestData *data;

@end

@interface TestData : JSONModel

@property (nonatomic, strong) NSString *lastid;

@property (nonatomic, strong) NSArray<TestModelItem> *list;

@end


@interface TestModelItem : JSONModel

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *cate_name;

@end
