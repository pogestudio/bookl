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
    SignupResponseSuccess = 0,
    SignupResponseDoubleUsername = -1,
    SignupResponseDoubleEmail = -2,
    SignupResponseTimeout = -3,
} SignupResponse;

typedef enum {
    LoginResponseSuccess = 1,
    LoginResponseIncorrect = 401,
    LoginResponseTimeout = -2
} LoginResponse;

@protocol SignupResponseDelegate <NSObject>

-(void)responseFromSignupAction:(SignupResponse)signupResponse;

@end

@protocol LoginResponseDelegate <NSObject>

-(void)responseFromLogin:(LoginResponse)loginResponse;

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
-(void)logInWithStoredCredentialsWithDelegate:(id<LoginResponseDelegate>)delegate;
@end
