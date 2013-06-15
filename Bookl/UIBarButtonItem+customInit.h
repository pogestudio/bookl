//
//  UIBarButtonItem+customInit.h
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (customInit)

+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;
+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;

@end
