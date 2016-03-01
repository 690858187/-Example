//
//  GPSNaviViewController.m
//  officialDemoNavi
//
//  Created by LiuX on 14-9-1.
//  Copyright (c) 2014年 AutoNavi. All rights reserved.
//

#import "GPSNaviViewController.h"
#import "DownLoadMapViewController.h"
#import "CustomAnnotationView.h"
#import "CustomMAPointAnnotation.h"

NSInteger selectPointTag = 0;

@interface GPSNaviViewController () <AMapNaviViewControllerDelegate,AMapLocationManagerDelegate>

@property (nonatomic, assign) float lastMapZoomLevel;

@property (nonatomic, strong) AMapNaviViewController *naviViewController;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray *pointAnnotationGroupArr;

@property (nonatomic, strong) NSMutableArray *oldPointAnnotationGroupArr;

@property (nonatomic, strong) CustomAnnotationView *selectAnnotationView;

@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;

@property (nonatomic, assign) CLLocationCoordinate2D lastlocationCoordinate;

@property (nonatomic, assign) CustomMAPointAnnotation *selectPointAnnotation;

@end

@implementation GPSNaviViewController

#pragma mark - Life Cycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
    
    [self initNaviViewController];
    [self initLocationManager];
    //[self configSubViews];
    
    self.pointAnnotationGroupArr = [NSMutableArray array];
    self.oldPointAnnotationGroupArr = [NSMutableArray array];
    self.lastMapZoomLevel = -100;
    [self addSubViewMapView];
    //先进行单次定位
    [self locationOne];
    
}


- (void)initNav {
    
    UIButton *rightBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [rightBtn setTitle:@"离线地图" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(self.view.frame.size.width-60, 20, 66, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = btnItem;
    self.navigationItem.leftBarButtonItem = nil;
    
}

- (void)rightBtnAction {
    
    DownLoadMapViewController *downVC = [[DownLoadMapViewController alloc] init];
    [self.navigationController pushViewController:downVC animated:YES];
    
    
}

- (void)addSubViewMapView {
    
    self.mapView.showsUserLocation = YES;
    //后台定位
    self.mapView.pausesLocationUpdatesAutomatically = YES;
    //iOS9以上系统必须配置
    //self.mapView.allowsBackgroundLocationUpdates = YES;
    //地图缩放比例
    
    if (self.lastMapZoomLevel<0) {
         self.mapView.zoomLevel = AMapZoomLevel;
    }
    else {
        self.mapView.zoomLevel = self.lastMapZoomLevel;
    }
   
   
    self.mapView.frame = self.view.bounds;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
}



#pragma mark - Init & Construct

- (void)initNaviViewController
{
    if (_naviViewController == nil)
    {
        _naviViewController = [[AMapNaviViewController alloc] initWithMapView:self.mapView delegate:self];
    }
    _naviViewController.delegate = self;
}

- (void)initLocationManager {
    
    if (_locationManager == nil) {
        _locationManager = [[AMapLocationManager alloc] init];
        
    }
    _locationManager.delegate = self;
}


#pragma mark - Button Action

- (void)startGPSNavi:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    // 算路
    [self calculateRoute];
}

- (void)calculateRoute
{
    
    CustomMAPointAnnotation *pointAnnotation = [self getSelectPointAnnotationInMapView];
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:pointAnnotation.coordinate.latitude longitude:pointAnnotation.coordinate.longitude];
    [self.naviManager calculateDriveRouteWithEndPoints:@[endPoint] wayPoints:nil drivingStrategy:0];
}

#pragma mark - AMapNaviManager Delegate

- (void)naviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{
    [super naviManager:naviManager didPresentNaviViewController:naviViewController];
    
    [self.naviManager startGPSNavi];
    
}

- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    [super naviManagerOnCalculateRouteSuccess:naviManager];
    
    [self.naviManager presentNaviViewController:self.naviViewController animated:YES];
}

#pragma mark - AManNaviViewController Delegate

- (void)naviViewControllerCloseButtonClicked:(AMapNaviViewController *)naviViewController
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       // [self.iFlySpeechSynthesizer stopSpeaking];
    });
    
    [self.naviManager stopNavi];
    
    [self.naviManager dismissNaviViewControllerAnimated:YES];
   
    [self restoreMapView];
}

- (void)naviViewControllerMoreButtonClicked:(AMapNaviViewController *)naviViewController
{
    if (self.naviViewController.viewShowMode == AMapNaviViewShowModeCarNorthDirection)
    {
        self.naviViewController.viewShowMode = AMapNaviViewShowModeMapNorthDirection;
    }
    else
    {
        self.naviViewController.viewShowMode = AMapNaviViewShowModeCarNorthDirection;
    }
}

- (void)naviViewControllerTurnIndicatorViewTapped:(AMapNaviViewController *)naviViewController
{
    [self.naviManager readNaviInfoManual];
}


#pragma mark-----MAMapViewDelegate

#pragma mark-----关于大头针的回调

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[CustomMAPointAnnotation class]])
    {
        CustomMAPointAnnotation *pointAnnotation = (CustomMAPointAnnotation *)annotation;
        
        static NSString *pointReuseIndentifier = @"annotationReuseIndetifier";
        CustomAnnotationView*annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];

        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            
        }
        annotationView.data = pointAnnotation.data;
        //储存数据
        [pointAnnotation.data save];
        
        annotationView.tag = [pointAnnotation.data.id integerValue]+100000;
        
        if ([pointAnnotation.data.id integerValue]==selectPointTag) {
            
            annotationView.image = [UIImage imageNamed:@"point_selected"];
        }
        
        //设置中心心点偏移,使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}


/*!
 @brief 当选中一个annotation views时调用此接口
 @param mapView 地图View
 @param views 选中的annotation views
 */

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    self.selectAnnotationView.image = [UIImage imageNamed:@"point"];
    [self.selectAnnotationView setSelected:NO animated:YES];
    view.image = [UIImage imageNamed:@"point_selected"];
    [view setSelected:YES animated:YES];

    self.selectAnnotationView = (CustomAnnotationView *)view;
    selectPointTag = self.selectAnnotationView.tag - 100000;

    //弹出提醒框
    __weak GPSNaviViewController *weakSelf = self;
    UIAlertController  *alertVC = [UIAlertController alertControllerWithTitle:@"导航" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *guideAction = [UIAlertAction actionWithTitle:@"导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //在吊起导航之前把数据库选中标注modle改变

        [weakSelf startGPSNavi:nil];
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:guideAction];
    [self presentViewController:alertVC animated:YES completion:^{
        
        
    }];

}



/*!
 @brief 地图区域即将改变时会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    self.lastlocationCoordinate = mapView.centerCoordinate;
}

/*!
 @brief 地图区域改变完成后会调用此接口
 @param mapview 地图View
 @param animated 是否动画
 */

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    self.locationCoordinate = mapView.centerCoordinate;
    self.lastMapZoomLevel = self.mapView.zoomLevel;
    CGFloat distance = 0;
    NSLog(@"====mapView.centerCoordinate:lat:%f lng:%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    // NSLog(@"lastCoordinate:lat:%f lng:%f",lastCoordinate.latitude,lastCoordinate.longitude);
    distance = [self calculateDistanceWithStarCLLocationCoordinate2D:mapView.centerCoordinate EndCLLocationCoordinate2D:self.lastlocationCoordinate];
    //NSLog(@"＝＝＝＝＝距离:%f",distance);
    
    if (distance<=AMapSlidingDistance&&distance>=300) {//向地图添加新数据
        
        [self requestData];
        
    }
    if (distance>AMapSlidingDistance) {
        
        [self requestData];
    }

}


#pragma mark-----Private Method

/**
 *  单次定位
 */

- (void)locationOne {
    
    //设置定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    
    __weak GPSNaviViewController *weakSelf = self;
    // 带逆地理（返回坐标和地址信息）
    [_locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
    
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
        }
        else {
        NSLog(@"location:%@", location);
            self.mapView.centerCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            
            [weakSelf requestData];
        }

        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}

/**
 *  请求数据
 */

- (void)requestData
{
    ParksByRegionParam *param = [[ParksByRegionParam alloc] init];
    param.lat = [NSString stringWithFormat:@"%.f",self.mapView.centerCoordinate.latitude*1000000];
    param.lng = [NSString stringWithFormat:@"%.f",self.mapView.centerCoordinate.longitude*1000000];
    param.maxcount = @"50";
    param.maxid = @"0";
    param.radius = AMapRadius;
    param.orderby = @"0";
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    
    [ParksByRegionHttp parkQueryParkingInfoByRegionWithParams:param successBlock:^(NSArray *dataArr, NSError *error) {
        
        if (!error) {
            
            [self.pointAnnotationGroupArr removeAllObjects];
            [self.mapView removeAnnotations:self.pointAnnotationGroupArr];
            
            for (ParksByRegionData *data in dataArr) {
                
                CustomMAPointAnnotation *pointAnnotation = [[CustomMAPointAnnotation alloc] init];
                double lat = [data.lat doubleValue]*1.0000000/1000000;
                double lng = [data.lng doubleValue]*1.0000000/1000000;
                pointAnnotation.data = data;
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
                [self.pointAnnotationGroupArr addObject:pointAnnotation];
                
            }
            [self updateMapViewPoints];
           
        }
        else {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        
    }];
    
}

/**
 *  更新页面标注
 */

- (void)updateMapViewPoints {
    
    [self.mapView addAnnotations:self.pointAnnotationGroupArr];
    self.oldPointAnnotationGroupArr = [NSMutableArray arrayWithArray:self.pointAnnotationGroupArr];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}

/**
 *  恢复原来的地图状态
 */

- (void)restoreMapView {
    
    [self addSubViewMapView];
    self.mapView.centerCoordinate = self.locationCoordinate;
    [self updateMapViewPoints];
    
}


/**
 *  通过开始位置和结束位置计算距离
 *
 *  @param starLocation 开始坐标
 *  @param endLocation  结束坐标
 *
 *  @return 距离
 */

- (CGFloat)calculateDistanceWithStarCLLocationCoordinate2D:(CLLocationCoordinate2D )starLocation
                                 EndCLLocationCoordinate2D:(CLLocationCoordinate2D )endLocation {
    //1.转换平面投影坐标
    MAMapPoint point1 = MAMapPointForCoordinate(starLocation);
    MAMapPoint point2 = MAMapPointForCoordinate(endLocation);
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    return distance;
}

/**
 *  获取选中的标注
 *
 *  @return 选中的标注
 */

- (CustomMAPointAnnotation *)getSelectPointAnnotationInMapView {
    
    NSArray *arr = self.mapView.selectedAnnotations;
    if (arr) {
        self.selectPointAnnotation = arr[0];
        return arr[0];
    }else {
        return nil;
    }
}

@end
