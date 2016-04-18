//
//  PURemoteSettingsTests.m
//  PURemoteSettingsTests
//
//  Created by Danilo on 04/15/2016.
//  Copyright (c) 2016 Danilo. All rights reserved.
//

@import XCTest;
@import PURemoteSettings;

@interface Tests : XCTestCase; @end

@implementation Tests

- (void)testFeatures
{
    PURemoteSettings *settings = [[PURemoteSettings alloc] initWithServerURL:nil username:nil password:nil localFilename:@"SampleDataFeatures1"];

    XCTAssertEqual(settings.features.count, 2);

    NSArray *names = @[@"sesam_scan_map_btn", @"sesam_scan_menu_btn"];
    [settings.features enumerateObjectsUsingBlock:^(PUFeature *feature, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([names containsObject:feature.name]);

        if ([feature.name isEqualToString:@"sesam_scan_map_btn"]) {
            XCTAssertTrue(feature.isEnabled);
        }
        if ([feature.name isEqualToString:@"sesam_scan_menu_btn"]) {
            XCTAssertFalse(feature.isEnabled);
        }
    }];
}

- (void)testBookingNotifications
{
    PURemoteSettings *settings = [[PURemoteSettings alloc] initWithServerURL:nil username:nil password:nil localFilename:@"SampleDataBookingNotifications1"];

    XCTAssertEqual(settings.bookingNotifications.count, 5);

    NSArray *names = @[
        @"time_to_leave",
        @"near_location",
        @"near_entry",
        @"expiring",
        @"over",
    ];
    [settings.bookingNotifications enumerateObjectsUsingBlock:^(PUBookingNotification *notification, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([names containsObject:notification.name]);

        if ([notification.name isEqualToString:@"time_to_leave"]) {
            XCTAssertFalse(notification.isEnabled);
        } else {
            XCTAssertTrue(notification.isEnabled);
        }
    }];
}

@end

