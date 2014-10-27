//
//  BNRMapPoint.h
//  whereami
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 zhaoqh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface BNRMapPoint : NSObject <MKAnnotation>

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t;

@property (nonatomic,readonly)CLLocationCoordinate2D coordinate;

@property (nonatomic,copy) NSString *title;

@end
