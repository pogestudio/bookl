//
//  BKUserManager.h
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

typedef void (^ CompletionBlock)();

@protocol UserManagerDelegate

-(void)userIsLoggedIn;

@end

@interface BKUserManager : NSObject

+(BKUserManager*)sharedInstance;

-(void)setUpWithFacebookUser:(id<FBGraphUser>)user completionBlock:(CompletionBlock)completionBlock;
-(void)makeSureUserIsLoggedIn;
@end
