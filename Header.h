//
//  Header.h
//  OpenSource
//
//  Created by iBarretLee on 17/7/26.
//  Copyright © 2017年 iBarretLee. All rights reserved.
//

#ifndef Header_h
#define Header_h




/**
 *  强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 *  调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 *  示例：
 *  @cm_weakify_self
 *  [obj block:^{
 *  @cm_strongify_self
 *      self.property = something;
 *  }];
 */
#ifndef	cm_weakify_self
#if __has_feature(objc_arc)
#define cm_weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define cm_weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef	cm_strongify_self
#if __has_feature(objc_arc)
#define cm_strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define cm_strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif



/**< single */

#define DEFINE_SINGLETON_T_FOR_HEADER(className) \
\
+ (className *)shared##className;

#if !__has_feature(objc_arc)
#define DEFINE_SINGLETON_T_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [NSAllocateObject(self, 0, NULL) init]; \
}); \
return shared##className; \
}\
\
- (id)copyWithZone:(NSZone *)zone{\
return self;\
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone{\
return [self copyWithZone:zone];\
}\
\
- (id)retain{\
return self;\
}\
\
- (NSUInteger)retainCount{\
return NSUIntegerMax;\
}\
\
- (id)autorelease{\
return self;\
}\
\
- (oneway void)release{\
}
#else
#define DEFINE_SINGLETON_T_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[[self class] alloc] init]; \
}); \
return shared##className; \
}
#endif






#endif /* Header_h */
