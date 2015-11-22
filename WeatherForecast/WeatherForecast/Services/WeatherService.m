//
//  WeatherService.m
//  WeatherForecast
//
//  Created by Rajashekar on 19/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import "WeatherService.h"
#import "WeatherServiceConstants.h"

@implementation WeatherService

/*
 
 Method : To find the weather for particular location.
 param : location : the coordinates for which weather has to be found.
 param : compeletionBlock : Execution returns to this method after completion.
 
 */

-(void)findWeatherForLocation:(CLLocation *)location withCompletionBlockHandler:(void(^)(weather *weatherObj, NSError *error))handler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%f,%f",kProtocol,kWeatherforecasturl,kAPIKey,location.coordinate.latitude,location.coordinate.longitude]];

    NSURLSessionDataTask * sessionDatatTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                       {
                                           if(error)
                                           {
                                              handler(nil,error);
                                           }
                                           else
                                           {
                                              
                                                NSDictionary *responseDict  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                   
                                                   NSDictionary *summaryDictionary = [responseDict objectForKey:@"currently"];
                                                   
                                                   weather *currentweather = [[weather alloc] init];
                                                   currentweather.summary = [summaryDictionary objectForKey:@"summary"];
                                                   currentweather.temperature = [[summaryDictionary objectForKey:@"temperature"] stringValue];
                                                   currentweather.humidity = [[summaryDictionary objectForKey:@"humidity"] stringValue];
                                                   currentweather.windSpeed = [[summaryDictionary objectForKey:@"windSpeed"] stringValue];
                                                   handler(currentweather,nil);
                                            }
                                       }];
    [sessionDatatTask resume] ;

    
}

@end
