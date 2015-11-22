//
//  WeatherTableViewController.m
//  WeatherForecast
//
//  Created by Rajashekar on 21/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import "WeatherTableViewController.h"
#import "ServicesManager.h"

@interface WeatherTableViewController()
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windspeedLabel;

@end

@implementation WeatherTableViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    [self.refreshControl addTarget:self
                            action:@selector(getWeatherUpdatesForCurrentLocation)
                  forControlEvents:UIControlEventValueChanged];
    
    [self getWeatherUpdatesForCurrentLocation];

    
}
/*
 method : This method initiates calling the actual service for weather
 
 */

-(void)getWeatherUpdatesForCurrentLocation {
    
    [[ServicesManager sharedInstance] getWeatherForCurrentLocation:^(weather *weatherObj, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showAlertwithError:error];
            });
        }
        else if (weatherObj) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUIwithWeather:weatherObj];

            });
        }
        [self.refreshControl endRefreshing];
        
    }];

}
/*
 Method : This method updates the UI when the weather information is received.
 param : this is a weather object which has info about the weather.
 */
-(void)updateUIwithWeather:(weather *)todaysweather {
    _summaryLabel.text = todaysweather.summary;
    _temperatureLabel.text = todaysweather.temperature;
    _humidityLabel.text = todaysweather.humidity;
    _windspeedLabel.text = todaysweather.windSpeed;
    
}

/*
 method : To show alert message on screen when something is wrong.
 param : error object whose localized description is shown.
 
 */

-(void)showAlertwithError: (NSError *)error {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weather Forecast Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
/*
 method : sample method for unit test cases.
 */
-(NSString *) summaryLabelText {
    NSLog(@"summary label is %@",self.summaryLabel.text);
    return self.summaryLabel.text;
}



@end
