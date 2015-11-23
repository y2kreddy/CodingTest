//
//  ServicesManager.h
//  WeatherForecast
//
//  Created by Rajashekar on 21/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weather.h"

@interface ServicesManager : NSObject {
    
}

+(ServicesManager *)sharedInstance;

-(void)getWeatherForCurrentLocation :(void(^)(weather *weatherObj, NSError *error))handler;

-(void)stopWeatherUpdates;

@end
