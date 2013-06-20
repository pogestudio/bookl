//
//  BKTokenFetch.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKTokenFetch.h"

static BKTokenFetch *_sharedInstance;

@implementation BKTokenFetch

+(BKTokenFetch*)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[BKTokenFetch alloc] init];
    }
    return _sharedInstance;
}

-(NSString*)currentFBUserToken
{
    FBAccessTokenData * currentAccessToken = [super fetchFBAccessTokenData];
    NSString *currentToken = currentAccessToken.accessToken;
    return currentToken;
}

@end
