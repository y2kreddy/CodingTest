//
//  LocationServiceTests.m
//  WeatherForecast
//
//  Created by Rajashekar on 22/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LocationService.h"

@interface LocationServiceTests : XCTestCase
@property(nonatomic,strong) LocationService *locationService;
@end

@implementation LocationServiceTests

- (void)setUp {
    [super setUp];
    self.locationService = [[LocationService alloc] init];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.locationService = nil;
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // [service findWeatherForlatitude:klatitude andLongitude:klongitude];
    }];
}

-(void)testLocationObjectCreation {
    
    XCTAssertNotNil(_locationService, @"Object is nil");

}

-(void)testLocationUpdates {

     XCTestExpectation *completionExpectation = [self expectationWithDescription:@"sample text"];
    
    [_locationService retrieveCurrentLocationWithCompletionBlock:^(CLLocation *locationObj, NSError *error) {
        XCTAssertNotNil(locationObj, @"location object is nil");
        [completionExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
    
}


@end
