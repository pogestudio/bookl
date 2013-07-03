//
//  BKForgotCredentialsViewController.m
//  Bookl
//
//  Created by CA on 7/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKForgotCredentialsViewController.h"
#import "AFHTTPClient.h"

#define IMAGE_HEIGHT 576

typedef enum {
    ResetResponseError = 0,
    ResetResponseSuccess,
    ResetResponseTimeout,
} ResetResponse;

@interface BKForgotCredentialsViewController ()
{
    ResetResponse _latestResponse;
}
@end

@implementation BKForgotCredentialsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(IMAGE_HEIGHT-150,0,0,0)];
}


-(IBAction)sendEmail:(id)sender
{
    NSAssert([self.email isKindOfClass:[UITextField class]], @"wrong class from sender");
    NSString *email = self.email.text;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email",nil];
    AFHTTPClient *postClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    [postClient postPath:@"api/user/password/reset" parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, NSData* responseObject){
                     
                     NSString *stringFromData = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSLog(@"class of object is: %@",[responseObject class]);
                     NSLog(@"got success: %@",stringFromData);
                     ResetResponse responseFromServer = [stringFromData boolValue] ? ResetResponseSuccess : ResetResponseError;
                     [self gotResponseFromServer:responseFromServer];
                 }failure:^(AFHTTPRequestOperation *operation, NSError *error){
                     NSLog(@"login failure %@", [error localizedDescription]);
                     [self gotResponseFromServer:ResetResponseTimeout];
                 }];
}

-(void)gotResponseFromServer:(ResetResponse)serverResponse
{
    _latestResponse = serverResponse;
    switch (serverResponse) {
        case ResetResponseError:
        {
            [self showAlertWithTitle:@"Error" message:@"Email not found"];
        }
            break;
        case ResetResponseSuccess:
        {
            NSString *message = [NSString stringWithFormat:@"Email sent to %@",self.email.text];
            [self showAlertWithTitle:@"Success" message:message];
        }
            break;
        case ResetResponseTimeout:
        {
            [self showAlertWithTitle:@"Error" message:@"Connection timed out"];
            break;
        }
        default:
            NSAssert(nil, @"should never be here, wrong in server response callback");
            break;
    }
    
    
}

-(void)showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_latestResponse == ResetResponseSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
