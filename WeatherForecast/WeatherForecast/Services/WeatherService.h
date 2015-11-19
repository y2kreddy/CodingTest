//
//  WeatherService.h
//  WeatherForecast
//
//  Created by Rajashekar on 19/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weather.h"

@class WeatherService;
@protocol WeatherServiceDelegate <NSObject>

-(void)didReceiveDataFromWeatherService:(WeatherService *)serviceObject andTodaysWeatheris:(weather *)todaysweather;
-(void)didReceiveErrorFromWeatherService:(WeatherService *)serviceObject andErroris:(NSError *)connectionError;


@optional
-(void)startedServiceCall;
-(void)finishedServiceCall;

@end

@interface WeatherService : NSObject {
    
}
@property(nonatomic,assign) id<WeatherServiceDelegate> delegate;

-(void)findWeatherForlatitude:(NSString *)latitude andLongitude:(NSString *)longitude;
-(void)findWeatherForlatitude:(NSString *)latitude andLongitude:(NSString *)longitude withCompletionBlockHandler:(void(^)(weather *weatherObj, NSError *error))handler;


@end
