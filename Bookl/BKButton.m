//
//  BKButton.m
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKButton.h"

@implementation BKButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.topGradientColor = [UIColor redColor];
        self.bottomGradientColor = [UIColor blackColor];
        
        self.cornerRadius = 8.0f;
        
        self.titleColor = [UIColor whiteColor];
        [self layoutTitle];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self setGradientFrom:self.topGradientColor to:self.bottomGradientColor inFrame:rect];
    [self drawCornerRadius:self.cornerRadius];
}

-(void)setGradientFrom:(UIColor *)topColor to:(UIColor *)bottomColor inFrame:(CGRect)rect
{
    CAGradientLayer *aGradient = [CAGradientLayer layer];
    aGradient.frame = rect;
    aGradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor],
                        (id)[bottomColor CGColor],
                        nil];
    
    [self.layer insertSublayer:aGradient atIndex:0];
}

-(void)drawCornerRadius:(CGFloat)cornerRadius
{
    CALayer *buttonLayer = [self layer];
    [buttonLayer setCornerRadius:cornerRadius];
    [buttonLayer setMasksToBounds:YES];

}

-(void)layoutTitle
{
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
}

@end
