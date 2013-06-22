//
//  BKUserManager.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKUserManager.h"
#import "BKTokenFetch.h"
#import "BKHTTPClient.h"
#import "BKUserAuthVC.h"

static BKUserManager *_sharedInstance;

@implementation BKUserManager
{
    id<SignupResponseDelegate> _responseDelegate;
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
    BOOL userIsLoggedIn = NO;
    if (!userIsLoggedIn) {
        [BKUserAuthVC askForUserLogin];
    }
}

-(void)signupWithData:(NSDictionary *)userData withDelegate:(id<SignupResponseDelegate>)delegate
{
    _responseDelegate = delegate;
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
#warning INCOMPLETE
                 //NSString *stringFromData = [[NSString alloc] initWithData:responseObject encoding:];
                 NSLog(@"class of object is: %@",[responseObject class]);
                 NSLog(@"got success: %@",responseObject);
             }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                 NSLog(@"got failure: error %@",error);
             }];
}

#pragma mark Facebook Integration
-(void)loginWithFacebookToken:(NSString*)token
{
    
    NSString *path = @"/auth/header";
}

@end
