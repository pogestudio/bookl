//
//  TTUser.m
//  TurtleTail
//
//  Created by CA on 5/21/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTUser.h"
#import "TTLoginVC.h"

@implementation TTUser

+(TTUser*)loggedInUser
{
    return nil;
}

+(void)makeSureUserIsLoggedIn
{
    if ([TTUser loggedInUser] == nil) {
        [TTLoginVC askForLogin];
    }
}

@end
