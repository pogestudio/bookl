//
//  BKUserAuthBackground.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKUserAuthVC.h"

@interface BKUserAuthVC ()

@end

@implementation BKUserAuthVC

+(void)askForUserLogin
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    UIViewController *userAuthVC = [storyboard instantiateViewControllerWithIdentifier:@"UserAuthVC"];
    UIViewController *aVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    userAuthVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [aVC presentViewController:userAuthVC animated:YES completion:nil];
}


@end
