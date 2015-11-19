//
//  ViewController.m
//  WeatherForecast
//
//  Created by Rajashekar on 19/11/15.
//  Copyright (c) 2015 Rajashekar. All rights reserved.
//

#import "ViewController.h"
#import "WeatherService.h"
#import "Constants.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //  [self findTodaysWeather];
    
    [self findTodaysWeatherUsingBlocks];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Call Weatherservices

-(void)findTodaysWeather {
    
    WeatherService *service = [[WeatherService alloc] init];
    service.delegate = self;
    [service findWeatherForlatitude:klatitude andLongitude:klongitude];
    
}

-(void) findTodaysWeatherUsingBlocks {
    
    WeatherService *service = [[WeatherService alloc] init];
    [service findWeatherForlatitude:klatitude andLongitude:klongitude withCompletionBlockHandler:^(weather *weatherObj, NSError *error){
        
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
        
    }];
    
}
#pragma mark Update UI

-(void)updateUIwithWeather:(weather *)todaysweather {
    _summaryLabel.text = todaysweather.summary;
    _temperatureLabel.text = todaysweather.temperature;
    
}

-(void)showAlertwithError: (NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weather Forecast Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark WeatherService delegate methods
-(void)didReceiveDataFromWeatherService:(WeatherService *)serviceObject andTodaysWeatheris:(weather *)todaysweather {
    
    [self updateUIwithWeather:todaysweather];
    
}

-(void)didReceiveErrorFromWeatherService:(WeatherService *)serviceObject andErroris:(NSError *)connectionError {
    
    [self showAlertwithError:connectionError];
    
}

-(void)startedServiceCall {
    // use this method to show some inidicator on screen
}

-(void)finishedServiceCall {
    // use this method to remove inidicator on screen
}

@end
