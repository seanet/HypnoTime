//
//  HypnosisView.m
//  Hypnosister
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 zhaoqh. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView
@synthesize circleColor;
@synthesize boxLayer=_boxLayer;

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self setCircleColor:[UIColor greenColor]];
        
        _boxLayer=[[CALayer alloc]init];
        [_boxLayer setBounds:CGRectMake(0, 0, 80, 80)];
        [_boxLayer setPosition:CGPointMake(160, 140)];
        [_boxLayer setCornerRadius:5];
        [_boxLayer setShadowColor:[[UIColor darkGrayColor] CGColor]];
        [_boxLayer setShadowOffset:CGSizeMake(3, 3)];
        [_boxLayer setShadowRadius:5];
        [_boxLayer setShadowOpacity:1];
                
        UIColor *reddish=[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];
        [_boxLayer setBackgroundColor:[reddish CGColor]];
        
        [self.layer addSublayer:_boxLayer];
    }
    return self;
}

-(void)drawRect:(CGRect)dirtyRect
{
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGRect bounds=[self bounds];
    
    CGPoint center;
    center.x=bounds.origin.x+bounds.size.width/2.0;
    center.y=bounds.origin.y+bounds.size.height/2.0;
    NSInteger shortter_length=bounds.size.width<bounds.size.height?bounds.size.width:bounds.size.height;
    float maxRadius=(shortter_length-10)/2.0;
    
    CGContextSetLineWidth(ctx, 10);
    [[self circleColor]setStroke];
    
    for(float currentRadius=maxRadius;currentRadius>0;currentRadius-=20){
        CGContextAddArc(ctx,center.x,center.y,currentRadius,0.0,M_PI*2.0,YES);
        CGContextStrokePath(ctx);
    }
    
    NSString *text = @"you are getting sleepy";
    UIFont *font=[UIFont boldSystemFontOfSize:28];
    CGRect textRect=[text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    textRect.origin.x=center.x-textRect.size.width/2.0;
    textRect.origin.y=center.y-textRect.size.height/2.0;
    
    CGSize offset=CGSizeMake(4, 3);
    CGColorRef color=[[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(ctx, offset, 2.0, color);
    
    [text drawInRect:textRect withAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName,[UIColor greenColor],NSForegroundColorAttributeName, nil]];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion==UIEventSubtypeMotionShake){
        NSLog(@"Device started shaking");
        [self setCircleColor:[UIColor redColor]];
    }
}

-(void)setCircleColor:(UIColor *)clr
{
    circleColor=clr;
    [self setNeedsDisplay];
}

#pragma mark - touch events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t=[touches anyObject];
    CGPoint p=[t locationInView:self];
    [_boxLayer setPosition:p];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t=[touches anyObject];
    CGPoint p=[t locationInView:self];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [_boxLayer setPosition:p];
    [CATransaction commit];
}

@end
