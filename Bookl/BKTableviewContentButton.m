//
//  BKTableviewContentButton.m
//  Bookl
//
//  Created by CA on 6/16/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKTableviewContentButton.h"

@implementation BKTableviewContentButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.topGradientColor = [BKColors currentColors].buttonBackground;
        self.bottomGradientColor = [BKColors currentColors].buttonBackground;
        
        self.titleColor = [BKColors currentColors].buttonFontColor;
        [self layoutTitle];
    }
    return self;
}


@end
