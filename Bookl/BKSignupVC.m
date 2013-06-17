//
//  BKSignupVC.m
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSignupVC.h"

#define BACKGROUND_VIEW_TAG 2
#define IMAGE_HEIGHT 576


@interface BKSignupVC ()

@end

@implementation BKSignupVC


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setContentInset:UIEdgeInsetsMake(IMAGE_HEIGHT-150,0,0,0)];
}


#pragma mark Initial setup
//-(void)addBackgroundImage
//{
//    UIImage *image = [UIImage imageNamed:@"ipad_logo.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    CGFloat width = imageView.frame.size.width;
//    CGFloat height = imageView.frame.size.height;
//    CGFloat xPos = 0;
//    CGFloat yPos = 0;
//    CGRect rectForImage = CGRectMake(xPos, yPos, width, height);
//    imageView.frame = rectForImage;
//    //[imageView.layer setCornerRadius:15];
//    //imageView.layer.masksToBounds = YES;
//    
//    UIImage *image2 = [UIImage imageNamed:@"books_clear.png"];
//    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
//    width = imageView.frame.size.width;
//    height = imageView.frame.size.height;
//    xPos = 0;
//    yPos = IMAGE_HEIGHT;
//    rectForImage = CGRectMake(xPos, yPos, width, height);
//    imageView2.frame = rectForImage;
//    
//    UIView *background = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    background.tag = BACKGROUND_VIEW_TAG;
//    [background addSubview:imageView];
//    [background addSubview:imageView2];
//    self.tableView.backgroundView = background;
//}

-(IBAction)doneButtonPressed:(id)sender
{
    NSLog(@"done");
}

-(IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
