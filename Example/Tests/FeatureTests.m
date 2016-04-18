//
//  FeatureTests.m
//  PURemoteSettings
//
//  Created by Danilo Braband on 18.04.16.
//  Copyright © 2016 Danilo. All rights reserved.
//

@import XCTest;
@import PURemoteSettings;

@interface FeatureTests : XCTestCase; @end

@implementation FeatureTests

- (void)testFeatureIsEnabled
{
    PURemoteSettings *settings = [[PURemoteSettings alloc] initWithServerURL:nil username:nil password:nil localFilename:@"SampleDataFeatures1"];

    XCTAssertTrue([settings isFeatureEnabled:@"sesam_scan_map_btn"]);
    XCTAssertFalse([settings isFeatureEnabled:@"sesam_scan_menu_btn"]);

    XCTAssertFalse([settings isFeatureEnabled:@"not-defined"]);
}

@end
