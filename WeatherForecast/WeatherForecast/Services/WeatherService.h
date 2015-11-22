//
//  WeatherService.h
//  WeatherForecast
//
//  Created by Rajashekar on 19/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "weather.h"


@interface WeatherService : NSObject {
    
}

-(void)findWeatherForLocation:(CLLocation *)location withCompletionBlockHandler:(void(^)(weather *weatherObj, NSError *error))handler;


@end
