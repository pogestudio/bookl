//
//  TTLoginVC.m
//  TurtleTail
//
//  Created by CA on 5/21/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TTLoginVC.h"

#define BACKGROUND_VIEW_TAG 2
#define IMAGE_HEIGHT 576


@implementation TTLoginVC

+(void)askForLogin
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    TTLoginVC *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginTVC"];
    UIViewController *aVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [aVC presentViewController:loginVC animated:YES completion:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackgroundImage];
    [self.tableView setContentInset:UIEdgeInsetsMake(IMAGE_HEIGHT-150,0,0,0)];
}

#pragma mark Initial setup
-(void)addBackgroundImage
{
    UIImage *image = [UIImage imageNamed:@"ipad_logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat width = imageView.frame.size.width;
    CGFloat height = imageView.frame.size.height;
    CGFloat xPos = 0;
    CGFloat yPos = 0;
    CGRect rectForImage = CGRectMake(xPos, yPos, width, height);
    imageView.frame = rectForImage;
    //[imageView.layer setCornerRadius:15];
    //imageView.layer.masksToBounds = YES;
    
    UIImage *image2 = [UIImage imageNamed:@"books_clear.png"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    width = imageView.frame.size.width;
    height = imageView.frame.size.height;
    xPos = 0;
    yPos = IMAGE_HEIGHT;
    rectForImage = CGRectMake(xPos, yPos, width, height);
    imageView2.frame = rectForImage;
    
    UIView *background = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    background.tag = BACKGROUND_VIEW_TAG;
    [background addSubview:imageView];
    [background addSubview:imageView2];
    self.tableView.backgroundView = background;
}


-(IBAction)dismissWindow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
