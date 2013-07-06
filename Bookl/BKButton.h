//
//  BKButton.h
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKButton : UIButton

-(void)setGradientFrom:(UIColor*)topColor to:(UIColor*)bottomColor inFrame:(CGRect)rect;
-(void)drawCornerRadius:(CGFloat)cornerRadius;

-(void)layoutTitle;


@property (strong) UIColor *topGradientColor;
@property (strong) UIColor *bottomGradientColor;

@property (strong, nonatomic) UIColor *titleColor;
@property (assign) CGFloat cornerRadius;

@end
