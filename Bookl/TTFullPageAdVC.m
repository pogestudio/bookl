//
//  TTFullPageAdVC.m
//  TurtleTail
//
//  Created by CA on 5/9/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTFullPageAdVC.h"

static TTFullPageAdVC *_adPage;

@implementation TTFullPageAdVC

+(TTFullPageAdVC*)adPage
{
    if (!_adPage) {
        _adPage = [[TTFullPageAdVC alloc] init];
    }
    return _adPage;
}

-(void)showAds
{
    NSLog(@"Presenting ads in full view");
}

-(IBAction)dismissView
{
    [self dismissViewControllerAnimated:YES
                             completion:^(void){[self.adDelegate adIsDone];
                             }];
}


@end
