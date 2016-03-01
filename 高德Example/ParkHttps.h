//
//  ParkHttps.h
//  GaoDeExample
//
//  Created by 1234 on 16/1/20.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ParksByRegionParam;
@class ParksByRegionData;

typedef void(^LoginDataBlock)(NSArray *dataArr,NSError *error);

@interface ParksByRegionHttp : NSObject

+ (void)parkQueryParkingInfoByRegionWithParams:(ParksByRegionParam *)param
                                successBlock:(LoginDataBlock)success;

@end
