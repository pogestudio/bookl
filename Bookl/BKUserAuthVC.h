//
//  BKUserAuthBackground.h
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKUserAuthVC : UIViewController

@property (strong) UINavigationController *userAuthNavCon;

+(void)askForUserLogin;

@end
