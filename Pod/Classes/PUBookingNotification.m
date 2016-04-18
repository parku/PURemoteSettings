//
//  PUBookingNotification.m
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

#import "PUBookingNotification.h"

@interface PUBookingNotification ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, readonly) NSDictionary *properties;
@end

@implementation PUBookingNotification

- (instancetype)initWithName:(NSString *)name
                     enabled:(NSNumber *)enabled
                  properties:(NSDictionary *)properties
{
    self = [super init];
    if (!self) return nil;

    _name = name;
    _enabled = enabled.boolValue;
    _properties = properties;

    return self;
}

- (BookingNotificationType)type
{
    if ([self.properties[@"type"] isEqualToString:@"region"]) {
        return Region;
    }

    if ([self.name isEqualToString:@"time_to_leave"]) {
        return RegionTime;
    }

    return Time;
}

@end
