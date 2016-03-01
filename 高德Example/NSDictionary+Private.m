//
//  NSDictionary+Private.m
//  collectionView
//
//  Created by 1234 on 15/12/7.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "NSDictionary+Private.h"

@implementation NSDictionary (Private)
- (NSInteger)error {
    
    return [[[[[self objectForKey:@"ANSWERS"] lastObject] objectForKey:@"ANS_MSG_HDR"] objectForKey:@"MSG_CODE"]
 integerValue];
    
}

- (NSString *)errmsg {
    
    return [[[[self objectForKey:@"ANSWERS"] lastObject] objectForKey:@"ANS_MSG_HDR"] objectForKey:@"MSG_TEXT"];
}

- (NSArray *)data {
    
    return [[[self objectForKey:@"ANSWERS"] firstObject] objectForKey:@"ANS_COMM_DATA"];
}

- (NSString *)authseq {
    
    return [self objectForKey:@"authseq"];
}

#pragma mark-----提交返回信息返回数据解析头

- (NSInteger)status {
  return [[self objectForKey:@"status"] integerValue];
}

- (NSString *)error_msg {
    return [self objectForKey:@"error_msg"];
}

@end
