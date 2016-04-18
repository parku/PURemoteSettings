//
//  PUObject.h
//  Pods
//
//  Created by Danilo Braband on 18.04.16.
//
//

@import Foundation;

@protocol PUObject <NSObject>

@required
- (instancetype)initWithName:(NSString *)name
                     enabled:(NSNumber *)enabled
                  properties:(NSDictionary *)properties;

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, getter=isEnabled) BOOL enabled;

@end
