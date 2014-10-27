//
//  TimeViewController.m
//  HypnoTime
//
//  Created by zhaoqihao on 14-8-15.
//  Copyright (c) 2014年 com.ssr. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController

-(id)init
{
    self=[super init];
    if(self){
        UITabBarItem *tabBarItem=[self tabBarItem];
        [tabBarItem setTitle:@"Time"];
        [tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -1)];
        [tabBarItem setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
        UIImage *image=[UIImage imageNamed:@"first_selected"];
        [tabBarItem setImage:image];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(colorChanged:) name:@"colorHasChanged" object:nil];
}

-(void)colorChanged:(NSNotification *)note
{
    id poster=[note object];
    NSLog(@"%@" ,[NSString stringWithUTF8String:object_getClassName(poster)]);
    
    NSDictionary *dict=[note userInfo];
    NSString *newColor=[dict objectForKey:@"color"];
    [colorLabel setText:newColor];
}

-(IBAction)showCurrentTime:(id)sender
{
    NSDate *now=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    [timeLabel setText:[formatter stringFromDate:now]];
    
//    [self spinTimeLabel];
    [self bounceTimeLabel];
}

-(void)spinTimeLabel
{
    CABasicAnimation *spin=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];    
    [spin setToValue:[NSNumber numberWithFloat:M_PI*2.0]];
    [spin setDuration:1.0];
    
    CAMediaTimingFunction *tf=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [spin setTimingFunction:tf];
    
    [timeLabel.layer addAnimation:spin forKey:@"spinAnimation"];
}

-(void)bounceTimeLabel
{
    CAKeyframeAnimation *bounce=[CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D forward=CATransform3DMakeScale(1.4, 1.4, 1);
    CATransform3D back=CATransform3DMakeScale(0.7, 0.7, 1);
    CATransform3D forward_1= CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D back_1=CATransform3DMakeScale(0.9, 0.9, 1);
    
    [bounce setValues:[NSArray arrayWithObjects:[NSValue valueWithCATransform3D:CATransform3DIdentity], [NSValue valueWithCATransform3D:forward],[NSValue valueWithCATransform3D:back],[NSValue valueWithCATransform3D:forward_1],[NSValue valueWithCATransform3D:back_1], [NSValue valueWithCATransform3D:CATransform3DIdentity], nil]];
    [bounce setDuration:1];
    [timeLabel.layer addAnimation:bounce forKey:@"bounceAnimation"];
    
    CABasicAnimation *fade=[CABasicAnimation animationWithKeyPath:@"opacity"];
    [fade setFromValue:[NSNumber numberWithFloat:0.0]];
    [fade setToValue:[NSNumber numberWithFloat:1.0]];
    [fade setDuration:1.0];
    [timeLabel.layer addAnimation:fade forKey:@"fadeAnimation"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CATransition *transfer=[CATransition animation];
    [transfer setDuration:0.6];
    [transfer setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [transfer setType:kCATransitionMoveIn];
    [timeButton.layer addAnimation:transfer forKey:@"transfer"];
    
    [self showCurrentTime:nil];
}

@end
