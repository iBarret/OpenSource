//
//  ViewController.m
//  OpenSource
//
//  Created by iBarretLee on 17/7/25.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#import "ViewController.h"
#import "CMHttpNetworkManager.h"
#import "TestModel.h"

#define kRequestUrl  @"http://m.shougongke.com/index.php?&c=Course&a=CourseList&lastid=&gcate=%E6%95%99%E7%A8%8B&type=&id="

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[CMHttpNetworkManager sharedCMHttpNetworkManager] sendRequestWithUrl:kRequestUrl
                                                                  msgDict:nil
                                                               httpMethod:HttpMethodPOST
                                                        constructingBlock:^(CMHttpEventInfo *eventInfo) {
        eventInfo.responseClass = [TestModel class];
    } completionBlock:^(id responseData, NSError *error) {
        if ([responseData isKindOfClass:[TestModel class]]) {
            NSLog(@"response success");
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
