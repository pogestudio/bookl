//
//  TTFullPageAdVC.h
//  TurtleTail
//
//  Created by CA on 5/9/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTAdHandler.h"

@interface TTFullPageAdVC : UIViewController


@property (strong, nonatomic) id<AdControlDelegate> adDelegate;

+(TTFullPageAdVC*)adPage;

-(void)showAds;

@end
