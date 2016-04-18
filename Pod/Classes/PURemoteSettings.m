//
//  PURemoteSettings.m
//  Pods
//
//  Created by Danilo Braband on 15.04.16.
//
//

#import "PURemoteSettings.h"

#import "PURemoteSettings.h"
#import "PUObject.h"
#import "PURouter.h"
#import "PUFeature.h"
#import "PUBookingNotification.h"

@interface PURemoteSettings()
@property (nonatomic, copy, readonly) NSString *filename;
@property (nonatomic, strong, readonly) PURouter *router;
@end

@implementation PURemoteSettings

#pragma mark - public methods

- (instancetype)initWithServerURL:(NSURL *)url
                         username:(NSString *)username
                         password:(NSString *)password
                    localFilename:(NSString *)filename
{
    self = [super init];
    if (!self) return nil;

    _filename = filename;
    _router = [[PURouter alloc] initWithURL:url username:username password:password];

    NSURL *pathForStoredJSON = [self filePathForFileName:filename];
    NSAssert(pathForStoredJSON, [NSString stringWithFormat:@"Could not find a default json for PURemoteSettings at %@", pathForStoredJSON]);
    if (!pathForStoredJSON) return nil;

    NSData *data = [NSData dataWithContentsOfURL:pathForStoredJSON];
    [self updateWithJSONData:data];

    return self;
}

- (void)update:(void (^)(BOOL, NSError *error))completed
{
    NSURLRequest *request = self.router.request;
    [self performRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        if (error || data == nil) {
            completed(NO, error);
            return;
        }

        [self updateWithJSONData:data];
        BOOL saved = [self saveJSONToDisk:data];
        completed(saved, nil);
    }];
}

- (BOOL)isFeatureEnabled:(NSString *)name
{
    for (PUFeature *feature in self.features) {
        if ([feature.name isEqualToString:name]) {
            return feature.isEnabled;
        }
    }

    return false;
}

#pragma mark - private methods

- (NSURL *)storedDocumentsFilePathWithName:(NSString *)name
{
    NSURL *docsDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

    return [docsDir URLByAppendingPathComponent:[name stringByAppendingString:@".json"]];
}

- (NSURL *)filePathForFileName:(NSString *)name
{
    NSURL *fileDocsURL = [self storedDocumentsFilePathWithName:name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileDocsURL.path]) {
        return fileDocsURL;
    }

    return [[NSBundle mainBundle] URLForResource:name withExtension:@"json"];
}

- (BOOL)saveJSONToDisk:(NSData *)JSONData
{
    NSError *error;
    NSURL *url = [self storedDocumentsFilePathWithName:self.filename];
    BOOL success = [JSONData writeToURL:url options:NSDataWritingAtomic error:&error];
    if (error) {
        NSLog(@"Error saving PURemoteSettings json data: %@", error.localizedDescription);
    }

    return success;
}

- (void)updateWithJSONData:(NSData *)JSONdata
{
    NSError *error;
    id JSON = [NSJSONSerialization JSONObjectWithData:JSONdata options:0 error:&error];
    if (error) {
        NSLog(@"Could not serialize PURemoteSettings JSON: %@", error.localizedDescription);
        return;
    }

    // get features here
    _features = [self mapDictionary:JSON[@"features"] map:^id(NSDictionary *dict) {
        return [[PUFeature alloc] initWithName:dict[@"name"] enabled:dict[@"enabled"] properties:dict];
    }];

    // get booking notifications here
    _bookingNotifications = [self mapDictionary:JSON[@"booking"][@"notification"] map:^id(NSDictionary *dict) {
        return [[PUBookingNotification alloc] initWithName:dict[@"name"] enabled:dict[@"enabled"] properties:dict];
    }];
}

- (NSArray *)mapDictionary:(NSDictionary *)dict map:(id (^)(id object))block
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dict.allKeys.count];

    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSDictionary *obj, BOOL * _Nonnull stop) {
        // set name for new object
        NSMutableDictionary *mutableDict = [obj mutableCopy];
        [mutableDict setObject:name forKey:@"name"];

        id newObject = block(mutableDict);
        if (newObject) {
            [array addObject:newObject];
        }
    }];

    return array;
}

- (void)performRequest:(NSURLRequest *)request
     completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [task resume];
}

@end
