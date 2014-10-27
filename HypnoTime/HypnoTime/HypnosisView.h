//
//  HypnosisView.h
//  Hypnosister
//
//  Created by apple on 14-6-6.
//  Copyright (c) 2014年 zhaoqh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HypnosisView : UIView

@property (nonatomic,strong)CALayer *boxLayer;
@property (nonatomic,strong)UIColor *circleColor;

-(void)setCircleColor:(UIColor *)clr;

@end
