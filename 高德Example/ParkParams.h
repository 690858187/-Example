//
//  ParkParams.h
//  GaoDeExample
//
//  Created by 1234 on 16/1/20.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParksByRegionParam : NSObject
@property (nonatomic, copy) NSString *radius;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *maxid;
@property (nonatomic, copy) NSString *orderby;
@property (nonatomic, copy) NSString *maxcount;
//数据字典:1支持预约2不可预约
@property (nonatomic, copy) NSString *appointflag;
@end
