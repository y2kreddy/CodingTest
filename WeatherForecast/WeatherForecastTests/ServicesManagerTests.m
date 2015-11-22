//
//  ServicesManagerTests.m
//  WeatherForecast
//
//  Created by Rajashekar on 22/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "weather.h"
#import "ServicesManager.h"

@interface ServicesManagerTests : XCTestCase

@property(nonatomic,strong) ServicesManager *serviceManager;
@end

@implementation ServicesManagerTests

- (void)setUp {
    [super setUp];
    self.serviceManager = [ServicesManager sharedInstance];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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

-(void)testServiceForWeather {
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"sample text"];
    
    
  /*  [_weatherService findWeatherForLocation:_location withCompletionBlockHandler:^(weather *weatherObj, NSError *error) {
        NSLog(@"weather at this locaiton is %@",weatherObj.summary);
        XCTAssertNotNil(weatherObj, @"weather object is nil");
        [completionExpectation fulfill];
    }];*/
    
    [_serviceManager getWeatherForCurrentLocation:^(weather *weatherObj, NSError *error) {
        XCTAssertNotNil(weatherObj, @"weather object is nil");
        [completionExpectation fulfill];

    }];
    
    [self waitForExpectationsWithTimeout:20.0 handler:nil];
    
}

@end
