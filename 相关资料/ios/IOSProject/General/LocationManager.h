//
//  LocationManager.h
//  DrivingNeighborSchool
//
//  Created by Wan Kiwi on 14-6-19.
//  Copyright (c) 2014年 kiwiapp. All rights reserved.
//

#define NotificationLocationInit @"NotificationLocationDidInit"
#define NotificationLocationLocated @"NotificationLocationDidLocated"
#define NotificationLocationGeocode @"NotificationLocationDidGeocode"

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject {
    
}

@property (strong, nonatomic) CLLocationManager * locationManager;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString * locationText;
@property (strong, nonatomic) NSString * province;
@property (strong, nonatomic) NSString * city;
@property (strong, nonatomic) NSString * district;

@property (assign, nonatomic) BOOL initialized;
@property (nonatomic, readonly) BOOL needRelocate;

+ (LocationManager*)sharedManager;
- (BOOL)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (BOOL)reverseGeocodeLocation;

@end
