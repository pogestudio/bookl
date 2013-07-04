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

#import "NSString+de_encoding.h"
#import "PDKeychainBindings.h"

#import "AFHTTPClient+withHeader.h"
#import "AFNetworking.h"

static BKUserManager *_sharedInstance;

@interface BKUserManager()

-(BOOL)isLoggedIn;

@end

@implementation BKUserManager
{
    BOOL _isLoggedin;
}

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
    NSString *urlForPull = [NSString stringWithFormat:@"%@/auth/facebook?code=%@",URL_BASE_ADDRESS,token];
    
    NSLog(@"urlForPull: %@",urlForPull);
    
    
    NSURL *url = [NSURL URLWithString:urlForPull];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    //[client addAuthHeader];
    
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Received success in facebook auth: %@", responseObject);
        NSLog(@"Responseobject: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.response.statusCode == 500) {
            NSLog(@"Internal server error, statuscode 500");
        } else {
            NSLog(@"Got error with: %@",[error localizedDescription]);
        }
    }];
    [operation start];
    
    
    completionBlock();
}

-(void)makeSureUserIsLoggedIn
{
    BOOL userIsLoggedIn = [self isLoggedIn];
    if (!userIsLoggedIn) {
        [BKUserAuthVC askForUserLogin];
    }
}

-(void)signupWithData:(NSDictionary *)userData withDelegate:(id<SignupResponseDelegate>)delegate
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    [client postPath:@"api/signup/" parameters:userData
             success:^(AFHTTPRequestOperation *operation, NSData* responseObject){
                 NSString *stringFromData = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                 NSLog(@"class of object is: %@",[responseObject class]);
                 NSLog(@"got success: %@",stringFromData);
                 SignupResponse responseFromServer = (SignupResponse)[stringFromData intValue];
                 [delegate responseFromSignupAction:responseFromServer];
             }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                 [delegate responseFromSignupAction:SignupResponseTimeout];
             }];
}

#pragma mark Facebook Integration
-(void)loginWithFacebookToken:(NSString*)token
{
    
    NSString *path = @"/auth/header";
}



-(BOOL)isLoggedIn
{
    return _isLoggedin;
}

-(void)logoutUser
{
    [[PDKeychainBindings sharedKeychainBindings] setObject:@"" forKey:@"password"];
    _isLoggedin = NO;
    [self makeSureUserIsLoggedIn];
}

#pragma mark Network
-(void)logInWithStoredCredentialsWithDelegate:(id<LoginResponseDelegate>)delegate
{
    AFHTTPClient *postClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    [postClient addAuthHeader];
    
    [postClient postPath:@"api/login/" parameters:nil
                 success:^(AFHTTPRequestOperation *operation, NSData* responseObject){
                     
                     NSString *stringFromData = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSLog(@"class of object is: %@",[responseObject class]);
                     NSLog(@"got success: %@",stringFromData);
                     LoginResponse responseFromServer = [stringFromData boolValue] ? LoginResponseSuccess : (LoginResponse)[stringFromData intValue];
                     
                     [self sendBackLoginResponse:responseFromServer toDelegate:delegate];
                 }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     NSLog(@"login failure %@", [error localizedDescription]);
                     
                     [self sendBackLoginResponse:operation.response.statusCode toDelegate:delegate];
                 }];
    
}


-(void)updateDisplayName
{
    
    NSString *urlForPull = [NSString stringWithFormat:@"%@/api/user",URL_BASE_ADDRESS];
    
    NSURL *url = [NSURL URLWithString:urlForPull];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            //NSLog(@"Received JSON: %@",JSON);
                                                                                            [self receivedUserInfo:JSON];
                                                                                        }
                                                                                        failure:nil];
    [operation start];

}

-(void)receivedUserInfo:(id)json
{
    NSAssert([json isKindOfClass:[NSDictionary class]],@"wrong class");
    NSString *display_name = [((NSDictionary*)json) objectForKey:@"display_name"];
    [[PDKeychainBindings sharedKeychainBindings] setObject:display_name forKey:@"display_name"];
}

#pragma mark Delegate actions
-(void)sendBackLoginResponse:(LoginResponse)loginResponse toDelegate:(id<LoginResponseDelegate>)delegate
{
    switch (loginResponse) {
        case LoginResponseSuccess:
        {
            _isLoggedin = YES;
            [self updateDisplayName];
            break;
        }
            break;
        case LoginResponseIncorrect:
        {
            //No break, keep flowing to timeout
        }
        case LoginResponseTimeout:
        {
            _isLoggedin = NO;
            break;
        }
        default:
            NSAssert(nil,@"too many loginresponses in sendbakcloginresponse");
            break;
    }
    
    [delegate responseFromLogin:loginResponse];
}


@end
