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

#import "BKHTTPClient.h"

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
//    //multi thread
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userData
//                                                       options:kNilOptions // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//    
//    if (error) {
//        NSLog(@"got error...: %@",error);
//    }
    
//    BKHTTPClient *client = [BKHTTPClient sharedClient];
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
//    
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *path = [NSString stringWithFormat:@"api/signup/", jsonString];
//    NSLog(@"path:: %@",path);
//    NSHTTP *request = [client requestWithMethod:@"POST" path:path parameters:nil];
//    
//    
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//
//        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
//        
//        NSLog(@"success, response: %@",response);
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        // code for failed request goes here
//        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
//        NSLog(@"failure, response: %@",response);
//        if (response == nil) {
//            [delegate responseFromSignupAction:SignupResponseTimeout];
//        }
//    }];
//    
//    [operation start];
    
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

-(void)logInWithStoredCredentialsWithDelegate:(id<LoginResponseDelegate>)delegate
{
    NSString *password = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"password"];
    NSString *email = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"email"];

    AFHTTPClient *postClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    [postClient setAuthorizationHeaderWithUsername:email password:password];
    
    
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

-(BOOL)isLoggedIn
{
    return _isLoggedin;
}

-(void)logoutUser
{
    [[PDKeychainBindings sharedKeychainBindings] setObject:@"" forKey:@"password"];
}


#pragma mark Delegate actions
-(void)sendBackLoginResponse:(LoginResponse)loginResponse toDelegate:(id<LoginResponseDelegate>)delegate
{
    switch (loginResponse) {
        case LoginResponseSuccess:
        {
            _isLoggedin = YES;
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
