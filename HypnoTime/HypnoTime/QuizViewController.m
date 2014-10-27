//
//  QuizViewController.m
//  whereami
//
//  Created by apple on 14-5-29.
//  Copyright (c) 2014年 zhaoqh. All rights reserved.
//

#import "QuizViewController.h"
#import "BNRMapPoint.h"

@implementation QuizViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        UITabBarItem *item=[self tabBarItem];
        [item setTitle:@"Map"];
        [item setImage:[UIImage imageNamed:@"third_selected"]];
    }
    
    return self;
}

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@",newLocation);
    
    NSTimeInterval t=[[newLocation timestamp] timeIntervalSinceNow];
    if(t<-180){
        return;
    }
    
[self foundLocation:newLocation];
}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@",error);
}

-(void)dealloc
{
    [locationManager setDelegate:nil];
}

-(void)viewDidLoad
{
    [worldView setShowsUserLocation:YES];
    locationManager=[[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D loc=[userLocation coordinate];
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(loc, 25000, 25000);
    [worldView setRegion:region animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

-(void)findLocation
{
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

-(void)foundLocation:(CLLocation *)loc
{
    CLLocationCoordinate2D coord=[loc coordinate];
    BNRMapPoint *mp=[[BNRMapPoint alloc] initWithCoordinate:coord title:[locationTitleField text]];
    [worldView addAnnotation:mp];
    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(coord, 2500, 2500);
    [worldView setRegion:region animated:YES];
    
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

@end
