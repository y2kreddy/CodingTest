//
//  WeatherService.m
//  WeatherForecast
//
//  Created by Rajashekar on 19/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import "WeatherService.h"
#import "Constants.h"

@implementation WeatherService
@synthesize delegate;
-(void)findWeatherForlatitude:(NSString *)latitude andLongitude:(NSString *)longitude {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@,%@",kProtocol,kWeatherforecasturl,kAPIKey,latitude,longitude]];
    NSLog(@"URL IS %@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [NSOperationQueue currentQueue];
    
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(startedServiceCall)]) {
        [self.delegate startedServiceCall];

    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(didReceiveErrorFromWeatherService:andErroris:)]) {
            [self.delegate didReceiveErrorFromWeatherService:self andErroris:connectionError];
            }
        }
        
        else {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *summaryDictionary = [dict objectForKey:@"currently"];
        
        weather *currentweather = [[weather alloc] init];
        currentweather.summary = [summaryDictionary valueForKey:@"summary"];
        currentweather.temperature = [[summaryDictionary valueForKey:@"temperature"] stringValue];
        
            if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(didReceiveDataFromWeatherService:andTodaysWeatheris:)]) {

        [self.delegate didReceiveDataFromWeatherService:self andTodaysWeatheris:currentweather];
            }
        }
        
        if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(finishedServiceCall)]) {

        [self.delegate finishedServiceCall];
        }
    }];
    
}

-(void)findWeatherForlatitude:(NSString *)latitude andLongitude:(NSString *)longitude withCompletionBlockHandler:(void(^)(weather *weatherObj, NSError *error))handler {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/%@,%@",kProtocol,kWeatherforecasturl,kAPIKey,latitude,longitude]];
    
    NSLog(@"url here is %@",url);

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSOperationQueue *queue = [NSOperationQueue currentQueue];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
           handler(nil,connectionError);
        }
        
        else {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *summaryDictionary = [dict objectForKey:@"currently"];
            weather *currentweather = [[weather alloc] init];
            currentweather.summary = [summaryDictionary valueForKey:@"summary"];
            currentweather.temperature = [[summaryDictionary valueForKey:@"temperature"] stringValue];
            handler(currentweather,connectionError);
           
        }
        
      
    }];

    
}

@end
