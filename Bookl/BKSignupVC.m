//
//  BKSignupVC.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSignupVC.h"
#import "NSString+validateEmail.h"
#import "BKUserManager.h"

#import "PDKeychainBindings.h"

#define BACKGROUND_VIEW_TAG 2
#define IMAGE_HEIGHT 576

#define USERNAME_MINIMUM_LENGTH 4
#define PASSWORD_MINIMUM_LENGTH 6


typedef enum {
    SignupTextfieldUsername = 5,
    SignupTextfieldPassword,
    SignupTextfieldPasswordAgain,
    SignupTextfieldEmail,
    SignupTextfieldEmailAgain,
} SignupTextfield;


@interface BKSignupVC ()
{
    UITextField *_textFieldThatFailed;
}

@end

@implementation BKSignupVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(IMAGE_HEIGHT-150,0,0,0)];
}


#pragma mark Initial setup
-(IBAction)doneButtonPressed:(id)sender
{
    BOOL isOk = [self validateTextInput];
    if (isOk) {
        [self storeUsernameAndPassword];
        [self sendDataToServer];
    }
}

-(IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Textfield Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //we only care about when they press enter
    if (![string isEqualToString:@"\n"]) {
        return YES;
    }
    
    UITextField *nextTextfield;
    NSUInteger tag = textField.tag;
    switch (tag) {
        case SignupTextfieldUsername:
        {
            nextTextfield = self.password;
            break;
        }
        case SignupTextfieldPassword:
        {
            nextTextfield = self.passwordAgain;
            break;
        }
        case SignupTextfieldPasswordAgain:
        {
            nextTextfield = self.email;
            break;
        }
        case SignupTextfieldEmail:
        {
            nextTextfield = self.emailAgain;
            break;
        }
        case SignupTextfieldEmailAgain:
        {
            //last one, so just resign.
            [textField resignFirstResponder];
            break;
        }
        default:
            NSAssert(nil, @"Should never be here, wrong stuff in textfield tags. Forgot to add logic for an extra one?");
            break;
    }
    
    if (nextTextfield != nil) {
        [nextTextfield becomeFirstResponder];
    }
    return NO; //should never add the "\n"
}

//A-q, 0-9 på username. Minimum 4 (spelar väl ingen roll, så länge det inte är taget? kul om tidiga users kommer få "alex" etc .
//                                 PW: minimum 6 tecken.
//                                 mail: vanlig mail check

-(BOOL)validateTextInput
{
    BOOL isOk = YES;
    if (![self validateUsername]) {
        isOk = NO;
    } else if (![self validatePassword]) {
        isOk = NO;
    } else if (![self validateEmail]) {
        isOk = NO;
    }
    return isOk;
}

-(BOOL)validateUsername
{
    NSString *usernameRegex =@"[A-z0-9]*";
    NSPredicate *containsOk = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", usernameRegex];
    BOOL containsNothingWeird = [containsOk evaluateWithObject:self.username.text];
    
    if (!containsNothingWeird) {
        [self popUIAlertWithTitle:@"Username" message:@"Username can only contain characters A-Z,a-z,0-9" forFailedTextfield:self.username];
        return containsNothingWeird;
    }
    
    BOOL isLongEnough = [self.username.text length] >= USERNAME_MINIMUM_LENGTH;
    
    if (!isLongEnough) {
        NSString *message = [NSString stringWithFormat:@"Username has to contain at least %d characters", USERNAME_MINIMUM_LENGTH];
        [self popUIAlertWithTitle:@"Username" message:message forFailedTextfield:self.username];
        return isLongEnough;
    }
    
    return containsNothingWeird && isLongEnough;
}

-(BOOL)validatePassword
{

    BOOL isLongEnough = [self.password.text length] >= PASSWORD_MINIMUM_LENGTH;
    
    if (!isLongEnough) {
        NSString *message = [NSString stringWithFormat:@"The password has to contain at least %d characters", PASSWORD_MINIMUM_LENGTH];
        [self popUIAlertWithTitle:@"Password" message:message forFailedTextfield:self.password];
        return isLongEnough;
    }
    
    BOOL isTheSame = [self.password.text isEqualToString:self.passwordAgain.text];
    if (!isTheSame) {
        NSString *message = [NSString stringWithFormat:@"The passwords you entered are different"];
        [self popUIAlertWithTitle:@"Password" message:message forFailedTextfield:self.password];
    }
    
    return isLongEnough && isTheSame;
    
}

-(BOOL)validateEmail
{
    BOOL isCorrect = [self.email.text validateEmailFormatLiberal];
    if (!isCorrect) {
        NSString *message = [NSString stringWithFormat:@"The email is incorrectly formatted"];
        [self popUIAlertWithTitle:@"Email" message:message forFailedTextfield:self.email];
        return isCorrect;
    }
    
    BOOL isTheSame = [self.email.text isEqualToString:self.emailAgain.text];
    if (!isTheSame) {
        NSString *message = [NSString stringWithFormat:@"The emails you entered are different"];
        [self popUIAlertWithTitle:@"Email" message:message forFailedTextfield:self.emailAgain];
    }
    
    return isCorrect && isTheSame;
}

-(void)popUIAlertWithTitle:(NSString*)title message:(NSString*)message
{
    [self popUIAlertWithTitle:title message:message forFailedTextfield:nil];
}

-(void)popUIAlertWithTitle:(NSString*)title message:(NSString*)message forFailedTextfield:(UITextField*)failedTextfield
{
    if (failedTextfield) {
        _textFieldThatFailed = failedTextfield;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_textFieldThatFailed becomeFirstResponder];
}

#pragma mark Send to Server
-(void)sendDataToServer
{
    NSString *displayName = self.username.text;
    NSString *password = self.password.text;
    NSString *email  = self.email.text;
    NSString *country = [self countryOfUser];
    
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:displayName,@"display_name", password, @"password",email,@"email",country,@"country", nil];
    
    [[BKUserManager sharedInstance] signupWithData:info withDelegate:self];
    
}
-(NSString*)countryOfUser
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *country = [usLocale displayNameForKey: NSLocaleCountryCode value: countryCode];
    return country;
}

#pragma mark SignupResponseDelegate
-(void)responseFromSignupAction:(SignupResponse)signupResponse
{
    switch (signupResponse) {
        case SignupResponseSuccess:
        {
            [self loginWithStoredCredentials];
            break;
        }
        case SignupResponseDoubleUsername:
        {
            //show uialert
            [self popUIAlertWithTitle:nil message:@"The username is taken, please enter another"];
            break;
        }
        case SignupResponseDoubleEmail:
        {
            //show uialert
            [self popUIAlertWithTitle:nil message:@"The email is taken, please enter another"];
            break;
        }
        case SignupResponseTimeout:
        {
            //shw uialert
            [self popUIAlertWithTitle:nil message:@"The connection timed out. Try again!"];
            break;
        }
        default:
            NSAssert(nil, @"Should never be here, wrong in responseFromSignupAction");
            break;
    }
    
    NSLog(@"got response: %d",signupResponse);
}


#pragma mark Signup Response Actions
-(void)loginWithStoredCredentials
{
    [[BKUserManager sharedInstance] logInWithStoredCredentialsWithDelegate:self];
}

#pragma mark Login Response Actions
-(void)responseFromLogin:(LoginResponse)loginResponse
{
    switch (loginResponse) {
        case LoginResponseIncorrect:
        {
            
        }
            break;
        case LoginResponseSuccess:
        {
            
        }
            break;
        case LoginResponseTimeout:
        {
            
        }
            break;
        default:
            NSAssert(nil,@"Should never be here, wrong with responseFromLogin");
            break;
    }
    
    
}

#pragma mark Store and Load
-(void)storeUsernameAndPassword
{
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    
    [[PDKeychainBindings sharedKeychainBindings] setObject:email forKey:@"email"];
    [[PDKeychainBindings sharedKeychainBindings] setObject:password forKey:@"password"];
}


@end
