//
//  PUFeature.m
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

#import "PUFeature.h"

@interface PUFeature ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@end

@implementation PUFeature

- (instancetype)initWithName:(NSString *)name
                     enabled:(NSNumber *)enabled
                  properties:(NSDictionary *)properties
{
    self = [super init];
    if (!self) return nil;

    _name = name;
    _enabled = enabled.boolValue;

    return self;
}

@end
