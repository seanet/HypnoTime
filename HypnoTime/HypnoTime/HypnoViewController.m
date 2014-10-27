//
//  HypnoViewController.m
//  HypnoTime
//
//  Created by zhaoqihao on 14-8-4.
//  Copyright (c) 2014年 com.ssr. All rights reserved.
//

#import "HypnoViewController.h"

@interface HypnoViewController ()

@end

@implementation HypnoViewController

-(id)init
{
    self=[super init];
    if(self){
        UITabBarItem *tabItem=[self tabBarItem];
        [tabItem setTitle:@"Hypnosis"];
        UIImage *image=[UIImage imageNamed:@"second_selected"];
        [tabItem setImage:image];
    }
    return self;
}

-(void)loadView
{
    hypnosisView=[[HypnosisView alloc]init];
    [self setView:hypnosisView];
    hypnosisView.boxLayer.delegate=self;
    [hypnosisView.boxLayer setNeedsDisplay];

    UISegmentedControl *segmentControl=[[UISegmentedControl alloc]initWithItems:[[NSArray alloc] initWithObjects:@"绿色",@"红色",@"蓝色", nil]];
    segmentControl.frame=CGRectMake(20, 50, 200, 30);
    segmentControl.selectedSegmentIndex=0;
    segmentControl.tintColor=[UIColor greenColor];
    [segmentControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
}

-(void)change:(UISegmentedControl *)sender
{
    NSUInteger index=[sender selectedSegmentIndex];
    
    if(index==0){
        [hypnosisView setCircleColor:[UIColor greenColor]];
        sender.tintColor=[UIColor greenColor];
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"Green",@"color", nil];
        NSNotification *nc=[NSNotification notificationWithName:@"colorHasChanged" object:self userInfo:dict];
        [[NSNotificationCenter defaultCenter]postNotification:nc];
    }else if(index ==1){
        [hypnosisView setCircleColor:[UIColor redColor]];
        sender.tintColor=[UIColor redColor];
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"Red",@"color", nil];
        NSNotification *nc=[NSNotification notificationWithName:@"colorHasChanged" object:self userInfo:dict];
        [[NSNotificationCenter defaultCenter]postNotification:nc];
    }else if(index==2){
        [hypnosisView setCircleColor:[UIColor blueColor]];
        sender.tintColor=[UIColor blueColor];
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:@"Blue",@"color", nil];
        NSNotification *nc=[NSNotification notificationWithName:@"colorHasChanged" object:self userInfo:dict];
        [[NSNotificationCenter defaultCenter]postNotification:nc];
    }
}

#pragma mark - calayer delegate

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    [layer setContentsRect:CGRectMake(-0.2, -0.2, 1.4, 1.4)];
    [layer setContentsGravity:kCAGravityResizeAspect];
    
    UIImage *image=[UIImage imageNamed:@"first_selected"];
    CGImageRef imageRef=[image CGImage];

    CGRect boundingRect=CGContextGetClipBoundingBox(ctx);
    
    CGContextTranslateCTM(ctx, 0, boundingRect.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextDrawImage(ctx, boundingRect, imageRef);
    
    //animation
    
    CABasicAnimation *fader=[CABasicAnimation animationWithKeyPath:@"opacity"];
    [fader setDuration:1.5];
    [fader setFromValue:[NSNumber numberWithFloat:0.0]];
    [fader setToValue:[NSNumber numberWithFloat:1.0]];
    
    CAKeyframeAnimation *mover=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSMutableArray *vals=[NSMutableArray array];
    [vals addObject:[NSValue valueWithCGPoint:CGPointMake(layer.bounds.size.width/2, layer.bounds.size.height/2)]];
    [vals addObject:[NSValue valueWithCGPoint:CGPointMake(layer.bounds.size.width/2, hypnosisView.bounds.size.height- layer.bounds.size.height/2-49)]];
    [vals addObject:[NSValue valueWithCGPoint:CGPointMake(hypnosisView.bounds.size.width- layer.bounds.size.width/2, hypnosisView.bounds.size.height-layer.bounds.size.height/2-49)]];
    [vals addObject:[NSValue valueWithCGPoint:CGPointMake(hypnosisView.bounds.size.width-layer.bounds.size.width/2, layer.bounds.size.height/2)]];
    [vals addObject:[NSValue valueWithCGPoint:CGPointMake(160, layer.bounds.size.height/2)]];
    [vals addObject:[NSValue valueWithCGPoint:CGPointMake(160, 140)]];
    [mover setValues:vals];
    [mover setDuration:5.0];
    [mover setCalculationMode:kCAAnimationPaced];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    [group setAnimations:[NSArray arrayWithObjects:fader,mover, nil]];
    [group setDuration:5.0];
    [layer addAnimation:group forKey:@"animatin"];
}

@end
