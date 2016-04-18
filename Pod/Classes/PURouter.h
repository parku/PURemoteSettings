//
//  PURouter.h
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

@import Foundation;

@interface PURouter : NSObject

- (instancetype)initWithURL:(NSURL *)url
                   username:(NSString *)username
                   password:(NSString *)password;

@property (nonatomic, readonly) NSURLRequest *request;

@end
