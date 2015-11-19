//
//  WeatherForecastTests.m
//  WeatherForecastTests
//
//  Created by Rajashekar on 19/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WeatherService.h"
#import "weather.h"
#import "Constants.h"

@interface WeatherForecastTests : XCTestCase<WeatherServiceDelegate> {
    WeatherService *service;
    BOOL serviceDone;
}

@end

@implementation WeatherForecastTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    service  = [[WeatherService alloc] init];
    service.delegate = self;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    service = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        [service findWeatherForlatitude:klatitude andLongitude:klongitude];
    }];
}

- (void)testWeatherObjectCreation {
    
    XCTAssertNotNil(service, @"Object is nil");
    
}

- (void)testWeatherService {
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"sample text"];
    
    
    [service findWeatherForlatitude:klatitude andLongitude:klongitude withCompletionBlockHandler:^(weather *weatherObj, NSError *error) {
        XCTAssertNotNil(weatherObj, @"weather object is nil");
        [completionExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
    
}

-(void)didReceiveDataFromWeatherService:(WeatherService *)serviceObject andTodaysWeatheris:(weather *)todaysweather {
    
}
-(void)didReceiveErrorFromWeatherService:(WeatherService *)serviceObject andErroris:(NSError *)connectionError {
    
}


-(void)startedServiceCall {
    
}
-(void)finishedServiceCall {
    
}
@end
