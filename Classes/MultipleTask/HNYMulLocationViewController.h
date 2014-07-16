//
//  HNYMulLocationViewController.h
//  Demo
//
//  Created by chenzq on 7/15/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface HNYMulLocationViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationDistance storedLatitudeDelta;
    CLLocationDistance storedLongitudeDelta;
    UIBackgroundTaskIdentifier backgroundTask;
    NSTimeInterval backgroundUpdateInterval;
}

@property (nonatomic, strong) CLLocationManager *_locationManager;
@property (nonatomic, strong) IBOutlet MKMapView *_mapView;
@property (nonatomic, strong) NSMutableArray *_saveLocations;
@property (nonatomic, strong) NSTimer *_updateTimer;


@end
