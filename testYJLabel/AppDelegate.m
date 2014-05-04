//
//  AppDelegate.m
//  testYJLabel
//
//  Created by huxiaohui on 14-5-1.
//  Copyright (c) 2014年 huxiaohui000. All rights reserved.
//

#import "AppDelegate.h"
#import "YJLLabel.h"
#import "YJLDrawLabel.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    YJLLabel *label=[[YJLLabel alloc] initWithFrame:CGRectMake(80, 100, 160, 30)];
    label.text=@"     just for test!你好！®Ω～～～    ";
    label.backgroundColor=[UIColor clearColor];
    [self.window addSubview:label];
    [label release]; 
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
