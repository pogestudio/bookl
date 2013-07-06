//
//  BKSignupVC.h
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BKUserManager.h"
@interface BKSignupVC : UITableViewController <UITextFieldDelegate,UIAlertViewDelegate,SignupResponseDelegate,LoginResponseDelegate>

@property (strong) IBOutlet UITextField *username;
@property (strong) IBOutlet UITextField *password;
@property (strong) IBOutlet UITextField *passwordAgain;
@property (strong) IBOutlet UITextField *email;
@property (strong) IBOutlet UITextField *emailAgain;


@end
