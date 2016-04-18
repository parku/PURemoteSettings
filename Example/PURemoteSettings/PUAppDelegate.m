//
//  PUAppDelegate.m
//  PURemoteSettings
//
//  Created by Danilo on 04/15/2016.
//  Copyright (c) 2016 Danilo. All rights reserved.
//

#import "PUAppDelegate.h"

#import "PUViewController.h"

@implementation PUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[PUViewController alloc] init];
    [self.window makeKeyAndVisible];

    return YES;
}

@end
