//
//  LocationService.m
//  WeatherForecast
//
//  Created by Rajashekar on 21/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>


@interface LocationService ()<CLLocationManagerDelegate>

@property(nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong)  void (^Handler)(CLLocation *locationObj, NSError *error);

@end

@implementation LocationService
@synthesize currentLocation;

/*
 
 Method : To find the current location of the user.
 param : compeletionBlock : Execution returns to this method after completion either giving the locaiton object or error object.
 
 */

-(void)retrieveCurrentLocationWithCompletionBlock :(void(^)(CLLocation *locationObj, NSError *error))handler {
    self.Handler = handler;
    [self.locationManager startUpdatingLocation];

}

/*
 
 Method : To stop the location updates.
 
 */

-(void)stopUpdatinglocation {
    [_locationManager stopUpdatingLocation];
    self.locationManager = nil;
    self.Handler = nil;
    
}


/*
 
 Method : To create location manager object if it is not created already.
 
 */

-(CLLocationManager*)locationManager{
    
    if(!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationManager requestAlwaysAuthorization];
        }
    }
    return _locationManager;
    
}

#pragma mark Location Manager delegate methods.
/*
 method : call back method when the locaiton is changed or updated.
 param : manager, The locationmanager which invoked this method.
 param : locations, Array of possible locations the user is found in.
 
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations lastObject];
    
    [_locationManager stopUpdatingLocation];
    
    _Handler(currentLocation,nil);
    
}

/*
 method : call back method when the user changes the authorization for location updates.
 param : manager, The locationmanager which invoked this method.
 param : status, The current status of authorization.
 
 */
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
        } break;
        case kCLAuthorizationStatusDenied: {
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [_locationManager startUpdatingLocation];
        } break;
        default:
            break;
    }
}

/*
 method : call back method when location manager failed to get the location.
 param : manager, The locationmanager which invoked this method.
 param : error, The error object which changed
 
 */

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

    _Handler(nil,error);
    
}

@end
