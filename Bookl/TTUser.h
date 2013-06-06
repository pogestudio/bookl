//
//  TTUser.h
//  TurtleTail
//
//  Created by CA on 5/21/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUser : NSObject

+(TTUser*)loggedInUser;
//+(void)askForUserLogin;

+(void)makeSureUserIsLoggedIn;

@end
