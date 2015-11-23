//
//  ServicesManager.m
//  WeatherForecast
//
//  Created by Rajashekar on 21/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import "ServicesManager.h"
#import "LocationService.h"
#import "WeatherService.h"

@interface ServicesManager()

@property (nonatomic,strong) LocationService *locationService;
@property (nonatomic,strong) CLLocation *currentLocation;
@property (nonatomic,strong) WeatherService *weatherService;
@property (nonatomic,strong)  void (^Handler)(weather *weatherObj, NSError *error);

@end

@implementation ServicesManager

static ServicesManager *sharedInstance = nil;

/*
 method : To create singleton object for servicemanager.
 */

+(ServicesManager*)sharedInstance {
    if(!sharedInstance)
    {
        sharedInstance = [[ServicesManager alloc]init];
    }
    return sharedInstance;
}

/*
 method : method that initiates location service
 param : compeltionhandler, which is called when this task is done. This block is saved a member variable to be called later.
 */

-(void)getWeatherForCurrentLocation :(void(^)(weather *weatherObj, NSError *error))handler {
    
    self.Handler = handler;
    
    [self.locationService retrieveCurrentLocationWithCompletionBlock:^(CLLocation *locationObj, NSError *error) {
        if (locationObj) {
            _currentLocation = locationObj;
            [self callWeatherService];

        }else {
            _Handler(nil,error);
        }
    }];
    
}
/*
 method : method that calls the weather service.
 
 */
-(void)callWeatherService {
    [self.weatherService findWeatherForLocation:_currentLocation withCompletionBlockHandler:^(weather *weatherObj, NSError *error) {
        NSLog(@"weather is %@",weatherObj.summary);
        if (error) {
            _Handler(nil,error);
        }else
        _Handler(weatherObj,nil);
    }];
}

/*
 mehtod :
 */

-(void)stopWeatherUpdates {
    [self.locationService stopUpdatinglocation];
    self.locationService = nil;
    self.weatherService = nil;
}

/*
 method : method to initiate location service object.
 */
-(LocationService *)locationService {
    if (!_locationService) {
        _locationService = [[LocationService alloc] init];
    }
    return _locationService;
}

/*
 method : method to initiate weather service object.
 */
-(WeatherService *)weatherService {
    if (!_weatherService) {
        _weatherService = [[WeatherService alloc] init];
    }
    return _weatherService;
}



@end
