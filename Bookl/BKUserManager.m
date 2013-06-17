//
//  BKUserManager.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKUserManager.h"
#import "BKTokenFetch.h"

#import "BKUserAuthVC.h"

static BKUserManager *_sharedInstance;

@implementation BKUserManager

+(BKUserManager*)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[BKUserManager alloc] init];
    }
    return _sharedInstance;
}

-(void)setUpWithFacebookUser:(id<FBGraphUser>)user completionBlock:(CompletionBlock)completionBlock
{
    
    NSLog(@"fb user is received: %@",user.first_name);
    NSString *token = [[BKTokenFetch sharedInstance] currentFBUserToken];
    NSLog(@"current token:%@",token);
    completionBlock();
}

-(void)makeSureUserIsLoggedIn
{
    BOOL userIsLoggedIn = NO;
    if (!userIsLoggedIn) {
        [BKUserAuthVC askForUserLogin];
    }
}

@end
