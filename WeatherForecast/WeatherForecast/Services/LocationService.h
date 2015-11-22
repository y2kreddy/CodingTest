//
//  LocationService.h
//  WeatherForecast
//
//  Created by Rajashekar on 21/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface LocationService : NSObject {
    
}
@property(nonatomic,readonly) CLLocation *currentLocation;
-(void)retrieveCurrentLocationWithCompletionBlock :(void(^)(CLLocation *locationObj, NSError *error))handler;
@end
