//
//  ParkDatas.m
//  GaoDeExample
//
//  Created by 1234 on 16/1/20.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "ParkDatas.h"

@implementation ParksByRegionData


- (BOOL)saveNoRepeatData {
   ParksByRegionData *data  =  [ParksByRegionData findFirstByCriteria:[NSString stringWithFormat:@"WHERE id = %@",self.id]];
    
    if (data) {
        data = self;
        NSLog(@"存在重复数据id＝%@",self.id);
        [data update];
        return YES;
    }
    else {
        [self save];
        return NO;
    }
}
@end
