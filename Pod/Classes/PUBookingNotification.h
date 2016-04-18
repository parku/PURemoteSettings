//
//  PUBookingNotification.h
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

@import Foundation;
#import "PUObject.h"

typedef NS_ENUM(short, BookingNotificationType) {
    Region = 0,
    Time,
    RegionTime
};

@interface PUBookingNotification : NSObject <PUObject>

@property (nonatomic, readonly) BookingNotificationType type;

@end
