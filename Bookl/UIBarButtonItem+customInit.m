//
//  UIBarButtonItem+customInit.m
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "UIBarButtonItem+customInit.h"
#import "BKColors.h"

#define CORNER_RADIUS 3.0f
@implementation UIBarButtonItem (customInit)

+ (UIBarButtonItem*)barItemWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [BKColors imageFromColor:[BKColors currentColors].barButtonBackground];
    UIImage *pressedButtonImage = [BKColors imageFromColor:[BKColors currentColors].barButtonBackground];
    
    [button setBackgroundImage: [buttonImage stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [button setBackgroundImage: [pressedButtonImage stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    button.frame= CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height) ];
    
    [v addSubview:button];
    
    UIBarButtonItem *newBarButton = [[UIBarButtonItem alloc] initWithCustomView:v];
    return newBarButton;
    
}


+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[BKColors currentColors].barButtonFont forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    UIImage *buttonImage = [BKColors imageFromColor:[BKColors currentColors].barButtonBackground];
    UIImage *pressedButtonImage = [BKColors imageFromColor:[BKColors currentColors].barButtonPressedBackground];
    
    [button setBackgroundImage: [buttonImage stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [button setBackgroundImage: [pressedButtonImage stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0] forState:UIControlStateHighlighted];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat padding = 10;
    CGFloat width = [title sizeWithFont:button.titleLabel.font].width + 2 * padding;
    button.frame = CGRectMake(0, 0, width, 30);
    
    CALayer *buttonLayer = [button layer];
    [buttonLayer setCornerRadius:CORNER_RADIUS];
    [buttonLayer setMasksToBounds:YES];
    
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, button.frame.size.width, button.frame.size.height) ];
    [v addSubview:button];
    
    UIBarButtonItem *newBarButton = [[UIBarButtonItem alloc] initWithCustomView:v];
    return newBarButton;
    
}


@end
