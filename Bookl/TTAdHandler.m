//
//  TTAdHandler.m
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTAdHandler.h"
#import "TTFullPageAdVC.h"

static TTAdHandler *_sharedHandler;

@implementation TTAdHandler

+(TTAdHandler*)sharedHandler
{
    if (!_sharedHandler) {
        _sharedHandler = [[TTAdHandler alloc] init];
    }
    return _sharedHandler;
}


-(void)showFullScreenAdWithDelegate:(id<AdControlDelegate>)delegate
{
    NSLog(@"Showing Fullscreen ad!");

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    TTFullPageAdVC *adVC = [storyboard instantiateViewControllerWithIdentifier:@"FullPageAdVC"];
    adVC.adDelegate = delegate;
    UIViewController *aVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    adVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [aVC presentViewController:adVC animated:YES completion:nil];

}

@end
