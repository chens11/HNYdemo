//
//  HNYMulLocationViewController.m
//  Demo
//
//  Created by chenzq on 7/15/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYMulLocationViewController.h"
#import "HNYStatusBar.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

#define RUNTIME 60*60
@interface HNYMulLocationViewController ()<UIAlertViewDelegate>

@end

@implementation HNYMulLocationViewController
@synthesize _locationManager;
@synthesize _mapView;
@synthesize _saveLocations;
@synthesize _updateTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    [self initData];
    
    //响应后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    
    CTCallCenter *callCenter = [[CTCallCenter alloc] init];
    callCenter.callEventHandler = ^(CTCall* call) {
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            NSLog(@"Call has been disconnected");
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            NSLog(@"Call has just been connected");
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"Call is incoming");
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"call is dialing");
        }
        else  
        {  
            NSLog(@"Nothing is done");  
        }  
    };
}



//初始化数据
-(void)initData{
    backgroundUpdateInterval = RUNTIME;//设置计时器时间
    
    
    self._saveLocations = [[NSMutableArray alloc] init];
    self._locationManager = [[CLLocationManager alloc] init];
    self._locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self._locationManager.delegate = self;
    [self._locationManager startUpdatingLocation];
    
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateSpan mySpan = [mapView region].span;
    storedLatitudeDelta = mySpan.latitudeDelta;
    storedLongitudeDelta = mySpan.longitudeDelta;
}


//吏新定位
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    //在地图上加大头针
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = newLocation.coordinate;
    [self._mapView addAnnotation:annotation];//
    [self._saveLocations addObject:annotation];
    
    
    if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)
    {
        if (backgroundTask != UIBackgroundTaskInvalid)//如果后台没有关闭，结束
        {
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
            backgroundTask = UIBackgroundTaskInvalid;
        }
        
        //显示所有的大头针
        for (MKPointAnnotation *annotation in self._saveLocations)
        {
            CLLocationCoordinate2D coordinate = annotation.coordinate;
            
            MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coordinate,storedLatitudeDelta ,storedLongitudeDelta);
            MKCoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
            [_mapView setRegion:adjustedRegion animated:NO];
        }
    }
    else
    {
        NSLog(@"applicationD in Background,newLocation:%@", newLocation);
    }
}




//用定时器控制后台运行定位时间
-(void)applicationDidEnterBackground:(NSNotificationCenter *)notication{
    UIApplication* app = [UIApplication sharedApplication];
    
    backgroundTask = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"applicationD in Background");
    }];
    
    
    //加入定时器，用来控制后台运行时间
    self._updateTimer = [NSTimer scheduledTimerWithTimeInterval:backgroundUpdateInterval
                                                         target:self
                                                       selector:@selector(stopUpdate)
                                                       userInfo:nil
                                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self._updateTimer forMode:NSRunLoopCommonModes];
}




//时间到，停止后台运行定位
-(void)stopUpdate{
    NSLog(@"stopUpdate");
    [self._locationManager stopUpdatingLocation];
    
    [self._updateTimer invalidate];
    self._updateTimer = nil;
    if (backgroundTask != UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTask];
        backgroundTask = UIBackgroundTaskInvalid;
    }
}





- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if(interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
		return YES;
	}else {
		return NO;
	}
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"localNotificationTest");
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.fireDate = [NSDate date];
    notif.timeZone = [NSTimeZone localTimeZone];
    notif.alertBody= [NSString stringWithFormat:@"tesssssssssss", 333];
    notif.alertAction = @"显示";
    notif.soundName= UILocalNotificationDefaultSoundName;
    notif.applicationIconBadgeNumber = ([UIApplication sharedApplication].applicationIconBadgeNumber + 1);
    notif.userInfo = [NSDictionary dictionaryWithObject:notif.alertBody forKey:@"kActivityNearByTotal"];
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    HNYStatusBar *status = [HNYStatusBar shareTipsWindow];
    [status showTips:@"fjdklj"];
    NSArray *array = [UIApplication sharedApplication].windows;
    

    UIWindow *tWindow = [[UIWindow alloc] initWithFrame:CGRectMake(80, -20, 200, 200)];
    tWindow.backgroundColor = [UIColor yellowColor];
    tWindow.windowLevel = UIWindowLevelStatusBar +10;
//    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(80, 200, 200, 200)];
//    test.backgroundColor = [UIColor yellowColor];
//    [keyWindow addSubview:test];
    [tWindow makeKeyAndVisible];
//    [keyWindow addSubview:tWindow];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}
@end
