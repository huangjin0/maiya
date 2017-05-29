//
//  LocationManager.m
//  DrivingNeighborSchool
//
//  Created by Wan Kiwi on 14-6-19.
//  Copyright (c) 2014年 kiwiapp. All rights reserved.
//

#define SetDefaultLocation [self setLocation:30.679943 lng:104.067923]

#define UseAMap 0

#if UseAMap
#import <AMapSearchKit/AMapSearchAPI.h>
#endif
#import "LocationManager.h"

static LocationManager * sharedLocationManager = nil;

@interface LocationManager () <CLLocationManagerDelegate> {//, AMapSearchDelegate> {
    BOOL _locating;
    BOOL _geoSearching;
    NSTimeInterval _expireTime;
}
@property (strong, nonatomic) NSDate * timestamp;
#if UseAMap
@property (strong, nonatomic) AMapSearchAPI * search;
#else
@property (strong, nonatomic) CLGeocoder * geocoder;
#endif
@end

@implementation LocationManager

+ (LocationManager*)sharedManager {
    if (sharedLocationManager == nil) {
        sharedLocationManager = [[LocationManager alloc] init];
    }
    return sharedLocationManager;
}

- (id)init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10.0f;
        _expireTime = 60 * 30;// default
#if UseAMap
        AMapSearchAPI * search = [[AMapSearchAPI alloc] initWithSearchKey:@"e0f5e3f9bdb34e46a71a774bb1a92c9a" Delegate:self];
        self.search = search;
#endif
    }
    return self;
}

CLLocationCoordinate2D GPS_to_GCJ02(CLLocationCoordinate2D coordinate) {
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    double wgLat = coordinate.latitude, wgLon = coordinate.longitude;
    double mgLat, mgLon;
    if (outOfChina(wgLat, wgLon)) {
        mgLat = wgLat;
        mgLon = wgLon;
        return CLLocationCoordinate2DMake(mgLat, mgLon);
    }
    double dLat = transformLat(wgLon - 105.0, wgLat - 35.0);
    double dLon = transformLon(wgLon - 105.0, wgLat - 35.0);
    double radLat = wgLat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    mgLat = wgLat + dLat;
    mgLon = wgLon + dLon;
    return CLLocationCoordinate2DMake(mgLat, mgLon);
}
inline static bool outOfChina(double lat, double lon) {
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}
inline static double transformLat(double x, double y) {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}
inline static double transformLon(double x, double y) {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

#pragma mark - Setters
- (void)setInitialized:(BOOL)initialized {
    if (_initialized != initialized) {
        _initialized = initialized;
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocationInit object:self];
    }
}
- (void)setLocationText:(NSString *)text {
    if (_locationText != text) {
        _locationText = text;
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocationGeocode object:self];
    }
}

#pragma mark - Getters
- (BOOL)needRelocate {
    NSDate * newLocDate = self.timestamp;
    NSTimeInterval interval = [newLocDate timeIntervalSinceNow];
    return (fabs(interval) > _expireTime);
}

#pragma mark - Public
- (BOOL)startUpdatingLocation {
    if (_locating || _geoSearching) return NO;
    _locating = YES;
    if ([CLLocationManager locationServicesEnabled]) {
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        } else {
            [_locationManager startUpdatingLocation];
        }
    } else {
        if (_coordinate.latitude == 0 && _coordinate.longitude == 0) {
            SetDefaultLocation;
        }
        AlertWithMessage(@"无法定位，请在设置－隐私设置中开启定位", nil);
    }
    return YES;
}
- (void)stopUpdatingLocation {
    [_locationManager stopUpdatingLocation];
#if UseAMap
    ;
#else
    [_geocoder cancelGeocode];
#endif
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self locationManagerUpdateLocation:newLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation * newLocation = [locations lastObject];
    [self locationManagerUpdateLocation:newLocation];
}
- (void)locationManagerUpdateLocation:(CLLocation*)newLocation {
    NSDate * newLocDate = newLocation.timestamp;
    NSTimeInterval interval = [newLocDate timeIntervalSinceNow];
    if (fabs(interval) < 5) {
        self.timestamp = newLocation.timestamp;
        CLLocationCoordinate2D coord = newLocation.coordinate;
        if (coord.latitude == 0 && coord.longitude == 0) {
            SetDefaultLocation;
        } else {
            //should get location string
            [self setLocation:coord.latitude lng:coord.longitude];
        }
        
        [_locationManager stopUpdatingLocation];
        _locating = NO;
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    SetDefaultLocation;
    [_locationManager stopUpdatingLocation];
    _locating = NO;
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusNotDetermined) {
//        NSLog(@"kCLAuthorizationStatusNotDetermined");
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
    } else if (status == kCLAuthorizationStatusRestricted) {
//        NSLog(@"kCLAuthorizationStatusRestricted");
    } else if (status == kCLAuthorizationStatusDenied) {
//        NSLog(@"kCLAuthorizationStatusDenied");
    } else if (status == kCLAuthorizationStatusAuthorized) {
//        NSLog(@"kCLAuthorizationStatusAuthorized");
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - Private
- (void)setLocation:(double)lat lng:(double)lng {
    self.coordinate = GPS_to_GCJ02(CLLocationCoordinate2DMake(lat, lng));
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocationLocated object:self];
    [self reverseGeocodeLocation];
}
- (BOOL)reverseGeocodeLocation {
    if (_geoSearching) return NO;
    _geoSearching = YES;
    
#if UseAMap
    // amap regeocode
    AMapReGeocodeSearchRequest * regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.searchType = AMapSearchType_ReGeocode;
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    regeoRequest.radius = 100;
    regeoRequest.requireExtension = NO;
    [self.search AMapReGoecodeSearch:regeoRequest];
#else
    // system regeocode
    CLLocation * loc = [[CLLocation alloc] initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    self.geocoder = [[CLGeocoder alloc] init];
    [_geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray * placemarks, NSError * error) {
        if (error) {
            self.locationText = String(@"UnknownLocation");
            NSLog(@"reverse Geocode error: %@", [error localizedDescription]);
        }
        if (placemarks.count > 0) {
            CLPlacemark * placemark = [placemarks lastObject];
            // City
            if (placemark.locality.hasValue) self.city = placemark.locality;
            else if (placemark.administrativeArea.hasValue) self.city = placemark.administrativeArea;
            // Name of Location
            NSMutableString * str = [NSMutableString string];
            [str appendFormat:@"%@", self.city];
            if (placemark.subLocality.hasValue) [str appendFormat:@"-%@", placemark.subLocality];
            if (placemark.thoroughfare.hasValue) [str appendFormat:@"-%@", placemark.thoroughfare];
            self.locationText = str;
        }
        _geoSearching = NO;
        if (!_initialized) {
            self.initialized = YES;
        }
    }];
#endif
    return YES;
}

#if UseAMap
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    _geoSearching = NO;
    if (![response isKindOfClass:[AMapReGeocodeSearchResponse class]]) {
        self.locationText = String(@"UnknownLocation");
        NSLog(@"reverse Geocode error");
        SetDefaultLocation;
        return;
    }
    NSString * result = response.regeocode.formattedAddress;
    if (!result.hasValue) {
        self.locationText = String(@"UnknownLocation");
        NSLog(@"reverse Geocode error");
        SetDefaultLocation;
        return;
    }
    self.province = response.regeocode.addressComponent.province;
    self.city = response.regeocode.addressComponent.city;
    self.district = response.regeocode.addressComponent.district;
    self.locationText = result;
    if (!_initialized) {
        self.initialized = YES;
    }
}
#endif

@end
