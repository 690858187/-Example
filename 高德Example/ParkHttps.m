//
//  ParkHttps.m
//  GaoDeExample
//
//  Created by 1234 on 16/1/20.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "ParkHttps.h"

#define ParksByRegionHttpURL @"85101005"

@implementation ParksByRegionHttp
+ (void)parkQueryParkingInfoByRegionWithParams:(ParksByRegionParam *)param
                                  successBlock:(LoginDataBlock)success {
    [self requestDataWithParam:[param mj_keyValues] Url:ParksByRegionHttpURL success:^(id resposeObject) {
        NSDictionary *resopseArr = resposeObject;
        if (resposeObject) {
            
            NSArray *arr = [ParksByRegionData mj_objectArrayWithKeyValuesArray:resposeObject];
            success (arr,nil);
            
        }
        
    } fail:^(NSError *error) {
        success (nil,error);
    }];
    
    
}
@end
