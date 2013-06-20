//
//  BKSignupVC.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSignupVC.h"
#import "NSString+validateEmail.h"

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
//-(void)addBackgroundImage
//{
//    UIImage *image = [UIImage imageNamed:@"ipad_logo.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    CGFloat width = imageView.frame.size.width;
//    CGFloat height = imageView.frame.size.height;
//    CGFloat xPos = 0;
//    CGFloat yPos = 0;
//    CGRect rectForImage = CGRectMake(xPos, yPos, width, height);
//    imageView.frame = rectForImage;
//    //[imageView.layer setCornerRadius:15];
//    //imageView.layer.masksToBounds = YES;
//    
//    UIImage *image2 = [UIImage imageNamed:@"books_clear.png"];
//    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
//    width = imageView.frame.size.width;
//    height = imageView.frame.size.height;
//    xPos = 0;
//    yPos = IMAGE_HEIGHT;
//    rectForImage = CGRectMake(xPos, yPos, width, height);
//    imageView2.frame = rectForImage;
//    
//    UIView *background = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    background.tag = BACKGROUND_VIEW_TAG;
//    [background addSubview:imageView];
//    [background addSubview:imageView2];
//    self.tableView.backgroundView = background;
//}

-(IBAction)doneButtonPressed:(id)sender
{
    [self validateTextInput];
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

-(void)validateTextInput
{
    if (![self validateUsername]) {
        return;
    }
    
    if (![self validatePassword]) {
        return;
    }
    
    if (![self validateEmail]) {
        return;
    }
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


-(void)popUIAlertWithTitle:(NSString*)title message:(NSString*)message forFailedTextfield:(UITextField*)failedTextfield
{
    _textFieldThatFailed = failedTextfield;
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
@end
