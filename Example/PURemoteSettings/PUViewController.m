//
//  PUViewController.m
//  PURemoteSettings
//
//  Created by Danilo on 04/15/2016.
//  Copyright (c) 2016 Danilo. All rights reserved.
//

#import "PUViewController.h"

@import PURemoteSettings;

#define URL @""
#define USERNAME @""
#define PASSWORD @""
#define LOCAL_FILE @"SampleData"

@implementation PUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:URL];
    PURemoteSettings *settings = [[PURemoteSettings alloc]
        initWithServerURL:url
        username:USERNAME
        password:PASSWORD
        localFilename:LOCAL_FILE
    ];

    NSLog(@"%@", settings.features);
    NSLog(@"%@", settings.bookingNotifications);

//    [settings update:^(BOOL updated, NSError *error) {
//        NSLog(@"updated");
//    }];
}

@end
