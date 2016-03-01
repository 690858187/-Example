//
//  BaseNaviViewController.h
//  officialDemoNavi
//
//  Created by 刘博 on 14-7-24.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

//#import "iflyMSC/IFlySpeechError.h"
//#import "iflyMSC/IFlySpeechSynthesizer.h"
//#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@interface BaseNaviViewController : UIViewController <MAMapViewDelegate,AMapNaviManagerDelegate,AMapLocationManagerDelegate
//,IFlySpeechSynthesizerDelegate
>

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapNaviManager *naviManager;

//@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

- (void)returnAction;

@end
