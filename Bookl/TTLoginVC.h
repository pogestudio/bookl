//
//  TTLoginVC.h
//  TurtleTail
//
//  Created by CA on 5/21/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface TTLoginVC : UITableViewController <FBLoginViewDelegate>

@property (strong) IBOutlet UIView *loginButton;
@property (strong) IBOutlet UIView *faceBookView;
@end
