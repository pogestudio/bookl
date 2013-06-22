//
//  BKUserManager.h
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

typedef enum {
    SignupResponseDoubleSuccess = 0,
    SignupResponseDoubleEmail = -1,
    SignupResponseDoubleUsername = -2,
    SignupResponseTimeout = -3,
} SignupResponse;

@protocol SignupResponseDelegate <NSObject>

-(void)responseFromSignupAction:(SignupResponse)signupResponse;

@end


typedef void (^ CompletionBlock)();

@protocol UserManagerDelegate

-(void)userIsLoggedIn;

@end

@interface BKUserManager : NSObject

+(BKUserManager*)sharedInstance;

-(void)setUpWithFacebookUser:(id<FBGraphUser>)user completionBlock:(CompletionBlock)completionBlock;
-(void)makeSureUserIsLoggedIn;

-(void)signupWithData:(NSDictionary*)userData withDelegate:(id<SignupResponseDelegate>)delegate;
@end
