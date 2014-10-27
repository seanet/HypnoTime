//
//  HypnoAppDelegate.m
//  HypnoTime
//
//  Created by zhaoqihao on 14-8-4.
//  Copyright (c) 2014年 com.ssr. All rights reserved.
//

#import "HypnoAppDelegate.h"
#import "HypnoViewController.h"
#import "TimeViewController.h"
#import "QuizViewController.h"

@implementation HypnoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HypnoViewController *hvc=[[HypnoViewController alloc]init];
    TimeViewController *timeViewController=[[TimeViewController alloc]init];
    QuizViewController *quizViewcontroller=[[QuizViewController alloc]init];
    
    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    NSArray *viewControllers=[NSArray arrayWithObjects:hvc,timeViewController,quizViewcontroller, nil];
    [tabBarController setViewControllers:viewControllers];
    
    [[self window]setRootViewController:tabBarController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
