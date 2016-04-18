//
//  PURemoteSettings.h
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

@import Foundation;

@class PUBookingNotification;
@class PUFeature;

@interface PURemoteSettings : NSObject

- (instancetype)initWithServerURL:(NSURL *)url
                         username:(NSString *)username
                         password:(NSString *)password
                    localFilename:(NSString *)filename;

- (void)update:(void (^)(BOOL updated, NSError *error))completed;

- (BOOL)isFeatureEnabled:(NSString *)name;

@property (nonatomic, copy) NSArray<PUBookingNotification *> *bookingNotifications;
@property (nonatomic, copy) NSArray<PUFeature *> *features;

@end
