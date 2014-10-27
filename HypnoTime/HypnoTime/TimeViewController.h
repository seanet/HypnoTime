//
//  TimeViewController.h
//  HypnoTime
//
//  Created by zhaoqihao on 14-8-15.
//  Copyright (c) 2014年 com.ssr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController
{
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *colorLabel;
    __weak IBOutlet UIButton *timeButton;
}

-(IBAction)showCurrentTime:(id)sender;

-(void)spinTimeLabel;
-(void)bounceTimeLabel;

@end
