//
//  QuizViewController.h
//  whereami
//
//  Created by apple on 14-5-29.
//  Copyright (c) 2014年 zhaoqh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface QuizViewController : UIViewController
<CLLocationManagerDelegate,MKMapViewDelegate,UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *worldView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationTitleField;
}

-(void)findLocation;
-(void)foundLocation:(CLLocation *)loc;

@end
