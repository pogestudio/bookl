//
//  TTLoginVC.m
//  TurtleTail
//
//  Created by CA on 5/21/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TTLoginVC.h"
#import "PDKeychainBindings.h"

#define IMAGE_HEIGHT 576


@interface TTLoginVC()

@end


@implementation TTLoginVC

+(void)askForLogin
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    UINavigationController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavCon"];
    UIViewController *aVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [aVC presentViewController:loginVC animated:YES completion:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(IMAGE_HEIGHT-150,0,0,0)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addFaceBookLoginView];
    
    UIButton *loginButton = (UIButton*)self.loginButton;
    [loginButton addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchUpInside];
    
    [self insertUNandPassword];
    
}

#pragma mark Initial setup
-(void)insertUNandPassword
{
    NSString *email = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"email"];
    NSString *password = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"password"];
    
    self.email.text = email;
    self.password.text = password;
    
}



-(IBAction)dismissWindow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addFaceBookLoginView
{
    UIView *cellToBePlacedIn = self.faceBookView.superview;
    [self.faceBookView removeFromSuperview];
    
    NSArray *readPermissions = [self FBreadPermissions];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:readPermissions];
    loginView.delegate = self;
    
    CGFloat xPos = (cellToBePlacedIn.frame.size.width - loginView.frame.size.width) / 2.0;
    CGFloat yPos = (cellToBePlacedIn.frame.size.height - loginView.frame.size.height) / 2.0;
    CGRect newFrame = CGRectMake(xPos,yPos,loginView.frame.size.width,loginView.frame.size.height);
    
    self.faceBookView = loginView;
    self.faceBookView.frame = newFrame;
    [cellToBePlacedIn addSubview:loginView];
    
}

-(NSArray*)FBreadPermissions
{
    return nil;
}
#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {

    NSLog(@"SHowing logged in user..?");
    //    // first get the buttons set for login mode
//    self.buttonPostPhoto.enabled = YES;
//    self.buttonPostStatus.enabled = YES;
//    self.buttonPickFriends.enabled = YES;
//    self.buttonPickPlace.enabled = YES;
//    
//    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
//    [self.buttonPostStatus setTitle:@"Post Status Update (Logged On)" forState:self.buttonPostStatus.state];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object

    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    [[BKUserManager sharedInstance] setUpWithFacebookUser:user completionBlock:^(void){
        NSLog(@"Completed assigning user");
    }];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    // test to see if we can use the share dialog built into the Facebook application
    FBShareDialogParams *p = [[FBShareDialogParams alloc] init];
    p.link = [NSURL URLWithString:@"http://developers.facebook.com/ios"];
#ifdef DEBUG
    [FBSettings enableBetaFeatures:FBBetaFeaturesShareDialog];
#endif
    BOOL canShareFB = [FBDialogs canPresentShareDialogWithParams:p];
    BOOL canShareiOS6 = [FBDialogs canPresentOSIntegratedShareDialogWithSession:nil];
    
    NSLog(@"User is logged out");
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    // see https://developers.facebook.com/docs/reference/api/errors/ for general guidance on error handling for Facebook API
    // our policy here is to let the login view handle errors, but to log the results
    NSLog(@"FBLoginView encountered an error=%@", error);
}

#pragma mark Our login
-(void)loginUser
{
    //store current credentials
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    
    [[PDKeychainBindings sharedKeychainBindings] setObject:email forKey:@"email"];
    [[PDKeychainBindings sharedKeychainBindings] setObject:password forKey:@"password"];
    
    [[BKUserManager sharedInstance] logInWithStoredCredentialsWithDelegate:self];
}

#pragma mark Login Response Delegate
-(void)responseFromLogin:(LoginResponse)loginResponse
{
    switch (loginResponse) {
        case LoginResponseSuccess:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
        case LoginResponseTimeout:
        {
            
            [self popUIAlertWithTitle:nil message:@"Connection timed out, please try again"];
            break;
        }
        case LoginResponseIncorrect:
        {
            [self popUIAlertWithTitle:nil message:@"Username or password is incorrect"];
            break;
        }
            
        default:
            NSAssert(nil,@"Should never be here, something is wrong with responseFromLogin in TTLoginVC");
            break;
    }
}

-(void)popUIAlertWithTitle:(NSString*)title message:(NSString*)message
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}


@end
