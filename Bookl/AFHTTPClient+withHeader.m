//
//  AFHTTPClient+withHeader.m
//  Bookl
//
//  Created by CA on 7/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "AFHTTPClient+withHeader.h"
#import "PDKeychainBindings.h"

@implementation AFHTTPClient (withHeader)

-(void)addAuthHeader
{
    NSAssert(URL_BASE_ADDRESS, @"need url base address for category");
    
    NSString *password = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"password"];
    NSString *username = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"email"];
    NSString *bookltoken = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"token_bookl"];
    
    if (bookltoken && ![bookltoken isEqualToString:@""]) {
        [self clearAuthorizationHeader];
        [self setAuthorizationHeaderWithToken:bookltoken];
    }
    if ((password && username)) {
        [self setAuthorizationHeaderWithUsername:username password:password];
    }
}

@end
