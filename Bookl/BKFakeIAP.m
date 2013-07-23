//
//  BKFakeIAP.m
//  Bookl
//
//  Created by CA on 7/23/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKFakeIAP.h"

@interface BKFakeIAP ()

@end

@implementation BKFakeIAP

-(IBAction)buyButtonPressed:(id)sender
{
    [self sendIndicationToFlurry];
    [self popAlert];
}

-(void)sendIndicationToFlurry
{
    NSString *boolKey = @"wantsAdRemoval";
    BOOL userHasIndicatedInterest = [[NSUserDefaults standardUserDefaults] boolForKey:boolKey];
    BOOL shouldSendEvent = !userHasIndicatedInterest;
    
    if (shouldSendEvent) {
        [Flurry logEvent:@"Purchase Ads"];
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:boolKey];
}

-(void)popAlert
{
    NSString *message = @"This feature is not yet implemented. We're aware of your interest, and will implement it as possible. Check back soon!";
    UIAlertView *interestAlert = [[UIAlertView alloc] initWithTitle:@"Ad removal"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
    [interestAlert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end