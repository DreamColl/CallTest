//
//  CallDirectoryHandler.m
//  CallKit
//
//  Created by 熊济源 on 2016/9/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "CallDirectoryHandler.h"

@interface CallDirectoryHandler () <CXCallDirectoryExtensionContextDelegate>
@end

@implementation CallDirectoryHandler{
    NSArray *numTest;
}

- (void)beginRequestWithExtensionContext:(CXCallDirectoryExtensionContext *)context {
    context.delegate = self;

    if (![self addBlockingPhoneNumbersToContext:context]) {
        NSLog(@"Unable to add blocking phone numbers");
        NSError *error = [NSError errorWithDomain:@"CallDirectoryHandler" code:1 userInfo:nil];
        [context cancelRequestWithError:error];
        return;
    }
    
    if (![self addIdentificationPhoneNumbersToContext:context]) {
        NSLog(@"Unable to add identification phone numbers");
        NSError *error = [NSError errorWithDomain:@"CallDirectoryHandler" code:2 userInfo:nil];
        [context cancelRequestWithError:error];
        return;
    }
    
    [context completeRequestWithCompletionHandler:nil];
}

- (BOOL)addBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve phone numbers to block from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    //
    // Numbers must be provided in numerically ascending order.
//    黑名单规则
//    1.当block和Identification有同样的号码时，黑名单优先
//    2.网上说当通讯录和黑名单有相同号码时，可以收到电话提示。但是经过测试，黑名单优先
//    3.黑名单内无号码，号码不为11位时，程序无法运行
    
    
    CXCallDirectoryPhoneNumber phoneNumbers[] = {8613601680499};
    NSUInteger count = (sizeof(phoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));

    for (NSUInteger index = 0; index < count; index += 1) {
        CXCallDirectoryPhoneNumber phoneNumber = phoneNumbers[index];
        [context addBlockingEntryWithNextSequentialPhoneNumber:phoneNumber];
    }

    return YES;
}

- (BOOL)addIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    // Retrieve phone numbers to identify and their identification labels from data store. For optimal performance and memory usage when there are many phone numbers,
    // consider only loading a subset of numbers at a given time and using autorelease pool(s) to release objects allocated during each batch of numbers which are loaded.
    //
    // Numbers must be provided in numerically ascending order.
    //标记规则，
    //    1.必须全部加国际区号如中国86，有一个号码没有区号，即无法运行。
    //    2.如果一个区号都不加，则标记无效，无法识别
    //    3.lables and phoneNumbers 必须一一对应，否则无法运行
    //    4.标记单和通讯录有相同号码，通讯录优先
    //    5.号码不能有+、-、空格
    //    6.CXCallDirectoryPhoneNumber 有一个容量限制 INT64_MAX - 1 能容纳多少号码待考量
    //    7.号码要求升序，同一个数组内只能有相同长度的号码。否则无法运行
    
    //将号码以NSArray的形式保存，转换为NSString再转换为CXCallDirectoryPhoneNumber
    for (int k=0; k<numTest.count; k++) {
        NSString *num = [numTest objectAtIndex:k];
        CXCallDirectoryPhoneNumber phoneNumbers[]={[num longLongValue]};
        
        NSUInteger count = (sizeof(phoneNumbers) / sizeof(CXCallDirectoryPhoneNumber));
        for (NSUInteger i = 0; i < count; i ++) {
            CXCallDirectoryPhoneNumber phoneNumber = phoneNumbers[i];
            NSString *label = @"骚扰电话";
            [context addIdentificationEntryWithNextSequentialPhoneNumber:phoneNumber label:label];
        }
    }
    return YES;
    //    NSArray<NSString *> *labels = @[ @"Telemarketer", @"Local business" ];
    //    CXCallDirectoryPhoneNumber phoneNumbers[] = {8618290054609};
}

#pragma mark - CXCallDirectoryExtensionContextDelegate

- (void)requestFailedForExtensionContext:(CXCallDirectoryExtensionContext *)extensionContext withError:(NSError *)error {
    // An error occurred while adding blocking or identification entries, check the NSError for details.
    // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
    //
    // This may be used to store the error details in a location accessible by the extension's containing app, so that the
    // app may be notified about errors which occured while loading data even if the request to load data was initiated by
    // the user in Settings instead of via the app itself.
}

-(void)setArray{
//js修改号码处
}


@end
