//
//  BaseNaviViewController.m
//  officialDemoNavi
//
//  Created by 刘博 on 14-7-24.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "BaseNaviViewController.h"
#import <AudioToolbox/AudioToolbox.h>
//#import "Toast+UIView.h"

@implementation BaseNaviViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTitle:self.title];
    
    [self initBaseNavigationBar];
    
    [self initMapView];
    
    [self initNaviManager];
    
    [self initIFlySpeech];

}

#pragma mark - Initialized

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
      
    }
    self.mapView.delegate = self;
//    //是否显示用户坐标
//    self.mapView.showsUserLocation = YES;
//    //后台定位
//    self.mapView.pausesLocationUpdatesAutomatically = NO;
//    //iOS9以上系统必须配置
//    //self.mapView.allowsBackgroundLocationUpdates = YES;
//    //地图缩放比例
//    self.mapView.zoomLevel = AMapZoomLevel;
//    
//    self.mapView.frame = self.view.bounds;
//    
//    self.mapView.delegate = self;
    
}

- (void)initNaviManager
{
    if (self.naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
    }
    
    self.naviManager.delegate = self;
}

- (void)initIFlySpeech
{
//    if (self.iFlySpeechSynthesizer == nil)
//    {
//        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
//    }
//    
//    _iFlySpeechSynthesizer.delegate = self;
}

- (void)initBaseNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(returnAction)];
}

- (void)initTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - Handle Action

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
}

#pragma mark - Utility

- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

#pragma mark - AMapNaviManager Delegate

- (void)naviManager:(AMapNaviManager *)naviManager error:(NSError *)error
{
    NSLog(@"error:{%@}",error.localizedDescription);
}

- (void)naviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{
    NSLog(@"didPresentNaviViewController");
}

- (void)naviManager:(AMapNaviManager *)naviManager didDismissNaviViewController:(UIViewController *)naviViewController
{
    NSLog(@"didDismissNaviViewController");
}

- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    NSLog(@"OnCalculateRouteSuccess");
}

- (void)naviManager:(AMapNaviManager *)naviManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure");
    
//    [self.view makeToast:@"算路失败"
//                duration:2.0
//                position:[NSValue valueWithCGPoint:CGPointMake(160, 240)]];
}

- (void)naviManagerNeedRecalculateRouteForYaw:(AMapNaviManager *)naviManager
{
    NSLog(@"NeedReCalculateRouteForYaw");
}

- (void)naviManager:(AMapNaviManager *)naviManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)naviManagerDidEndEmulatorNavi:(AMapNaviManager *)naviManager
{
    NSLog(@"DidEndEmulatorNavi");
}

- (void)naviManagerOnArrivedDestination:(AMapNaviManager *)naviManager
{
    NSLog(@"OnArrivedDestination");
}

- (void)naviManager:(AMapNaviManager *)naviManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint");
}

- (void)naviManager:(AMapNaviManager *)naviManager didUpdateNaviLocation:(AMapNaviLocation *)naviLocation
{
//    NSLog(@"didUpdateNaviLocation");
}

- (void)naviManager:(AMapNaviManager *)naviManager didUpdateNaviInfo:(AMapNaviInfo *)naviInfo
{
//    NSLog(@"didUpdateNaviInfo");
}

- (BOOL)naviManagerGetSoundPlayState:(AMapNaviManager *)naviManager
{
//    NSLog(@"GetSoundPlayState");
    
    return 0;
}

- (void)naviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    if (soundStringType == AMapNaviSoundTypePassedReminder)
    {
        //用系统自带的声音做简单例子，播放其他提示音需要另外配置
        AudioServicesPlaySystemSound(1009);
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
           // [_iFlySpeechSynthesizer startSpeaking:soundString];
        });
    }
}

- (void)naviManagerDidUpdateTrafficStatuses:(AMapNaviManager *)naviManager
{
    NSLog(@"DidUpdateTrafficStatuses");
}


//#pragma mark - iFlySpeechSynthesizer Delegate
//
//- (void)onCompleted:(IFlySpeechError *)error
//{
//    NSLog(@"Speak Error:{%d:%@}", error.errorCode, error.errorDesc);
//}

@end
