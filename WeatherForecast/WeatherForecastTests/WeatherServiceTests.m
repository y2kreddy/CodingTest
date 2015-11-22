//
//  WeatherServiceTests.m
//  WeatherForecast
//
//  Created by Rajashekar on 22/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WeatherService.h"


@interface WeatherServiceTests : XCTestCase
@property(nonatomic,strong) WeatherService *weatherService;
@property(nonatomic,strong) CLLocation *location;

@end

@implementation WeatherServiceTests

- (void)setUp {
    [super setUp];
    self.weatherService = [[WeatherService alloc] init];
    
    double latitiude = 8.391916;
    
    double longitude = 77.094315;
    
    _location = [[CLLocation alloc] initWithLatitude:latitiude longitude:longitude];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.weatherService = nil;
    self.location = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testWeatherObjectCreation {
    
    XCTAssertNotNil(_weatherService, @"Object is nil");
    
}

-(void)testWeatherUpdates {
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"sample text"];

    
    [_weatherService findWeatherForLocation:_location withCompletionBlockHandler:^(weather *weatherObj, NSError *error) {
        NSLog(@"weather at this locaiton is %@",weatherObj.summary);
        XCTAssertNotNil(weatherObj, @"weather object is nil");
        [completionExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}

@end
