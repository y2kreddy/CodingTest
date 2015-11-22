//
//  WeatherTableViewControllerTests.m
//  WeatherForecast
//
//  Created by Rajashekar on 22/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "WeatherTableViewController.h"
#import "weather.h"

@interface WeatherTableViewController()
-(NSString *)summaryLabelText;
-(void)updateUIwithWeather:(weather *)todaysweather;
@end

@interface WeatherTableViewControllerTests : XCTestCase
@property (nonatomic,strong) WeatherTableViewController *weatherTableViewControllerTest;
@property (nonatomic,strong) weather *currentWeather;
@property (nonatomic,strong) UIView *sampleView;

@end

@implementation WeatherTableViewControllerTests

- (void)setUp {
    [super setUp];
    self.weatherTableViewControllerTest = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WeatherTableViewControllerIdentifier"];
    [_sampleView addSubview:_weatherTableViewControllerTest.view];  // adding to subivew makes all the elements in nib initialized.
    self.currentWeather = [[weather alloc] init];
    _currentWeather.summary = @"Partly Cloudy";
    _currentWeather.temperature = @"56.09";
    _currentWeather.humidity = @"0.03";
    _currentWeather.windSpeed = @"3.57";
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    self.weatherTableViewControllerTest = nil;
    self.currentWeather = nil;
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

-(void)testAssigningModelObjectsToUIElements {
    

    [_weatherTableViewControllerTest updateUIwithWeather:_currentWeather];
    
    XCTAssertEqual([_weatherTableViewControllerTest summaryLabelText],@"Partly Cloudy",@"Model objects are not assigned to UI");
    
}

@end
