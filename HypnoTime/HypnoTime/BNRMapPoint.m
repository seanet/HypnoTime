//
//  BNRMapPoint.m
//  whereami
//
//  Created by apple on 14-6-5.
//  Copyright (c) 2014年 zhaoqh. All rights reserved.
//

#import "BNRMapPoint.h"

@implementation BNRMapPoint
@synthesize coordinate,title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self=[super init];
    if(self){
        coordinate=c;
        [self setTitle:t];
    }
    return self;
}

-(id)init{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(35, 116) title:@"Hometown"];
}

@end
