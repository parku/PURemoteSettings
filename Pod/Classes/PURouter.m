//
//  PURouter.m
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

#import "PURouter.h"

@interface PURouter ()
@property (nonatomic, readonly, copy) NSString *authentication;
@property (nonatomic, readonly, copy) NSURL *url;
@end

@implementation PURouter

#pragma mark - public methods

- (instancetype)initWithURL:(NSURL *)url username:(NSString *)username password:(NSString *)password
{
    self = [super init];
    if (!self) return nil;

    _authentication = [self authenticationHeaderWithUsername:username password:password];
    _url = url;

    return self;
}

- (NSURLRequest *)request
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    [request setValue:self.authentication forHTTPHeaderField:@"Authorization"];

    return request;
}

#pragma mark - private methods

- (NSString *)authenticationHeaderWithUsername:(NSString *)username
                                      password:(NSString *)password
{
    NSString *authString = [NSString stringWithFormat:@"%@:%@", username, password];
    NSData *authData = [authString dataUsingEncoding:NSASCIIStringEncoding];

    return [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]];
}

@end
