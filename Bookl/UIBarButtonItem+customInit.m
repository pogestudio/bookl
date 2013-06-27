//
//  UIBarButtonItem+customInit.m
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "UIBarButtonItem+customInit.h"
#import "BKColors.h"

#define CORNER_RADIUS 5.0f
@implementation UIBarButtonItem (customInit)

+ (UIBarButtonItem*)barItemWithTitle:(NSString*)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[BKColors currentColors].barButtonFont forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14.0]];
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

//-(void)setShadowToSelf
//{
//    // the image we're going to mask and shadow
//    UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sj.jpeg"]];
//    image.center = self.view.center;
//    
//    // make new layer to contain shadow and masked image
//    CALayer* containerLayer = [CALayer layer];
//    containerLayer.shadowColor = [UIColor blackColor].CGColor;
//    containerLayer.shadowRadius = 10.f;
//    containerLayer.shadowOffset = CGSizeMake(0.f, 5.f);
//    containerLayer.shadowOpacity = 1.f;
//    
//    // use the image's layer to mask the image into a circle
//    image.layer.cornerRadius = roundf(image.frame.size.width/2.0);
//    image.layer.masksToBounds = YES;
//    
//    // add masked image layer into container layer so that it's shadowed
//    [containerLayer addSublayer:image.layer];
//    
//    // add container including masked image and shadow into view
//    [self.view.layer addSublayer:containerLayer];
//}


@end
