//
//  BKHTTPClient.m
//  Bookl
//
//  Created by CA on 6/20/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKHTTPClient.h"

#import "PDKeychainBindings.h"

@implementation BKHTTPClient

+(BKHTTPClient *)sharedClient {
    static BKHTTPClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    });
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
//    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
//    self.parameterEncoding = AFJSONParameterEncoding;
    
    
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [self setLoginheader];

    return self;
}

-(void)setLoginheader
{
    NSString *password = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"password"];
    NSString *email = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"email"];
    
    if ((password && email)) {
        [self clearAuthorizationHeader];
        [self setAuthorizationHeaderWithUsername:email password:password];
    }
}
@end
