//
//  BookingNotificationTests.m
//  PURemoteSettings
//
//  Created by Danilo Braband on 18.04.16.
//  Copyright © 2016 Danilo. All rights reserved.
//

@import XCTest;
@import PURemoteSettings;

@interface BookingNotificationTests : XCTestCase; @end

@implementation BookingNotificationTests

- (void)testBookingNotificationType
{
    PURemoteSettings *settings = [[PURemoteSettings alloc] initWithServerURL:nil username:nil password:nil localFilename:@"SampleDataBookingNotifications1"];

    XCTAssertTrue(settings.bookingNotifications.count == 5);

    for (PUBookingNotification *notification in settings.bookingNotifications) {

        if ([notification.name isEqualToString:@"time_to_leave"]) {
            XCTAssertEqual(notification.type, RegionTime);
        }

        if ([notification.name isEqualToString:@"near_location"]) {
            XCTAssertEqual(notification.type, Region);
        }

        if ([notification.name isEqualToString:@"near_entry"]) {
            XCTAssertEqual(notification.type, Region);
        }

        if ([notification.name isEqualToString:@"expiring"]) {
            XCTAssertEqual(notification.type, Time);
        }

        if ([notification.name isEqualToString:@"over"]) {
            XCTAssertEqual(notification.type, Time);
        }

    }

}

@end
