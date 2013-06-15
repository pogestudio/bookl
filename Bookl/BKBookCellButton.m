//
//  BKBookCellButton.m
//  Bookl
//
//  Created by CA on 6/16/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKBookCellButton.h"

@implementation BKBookCellButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.topGradientColor = [BKColors currentColors].cellButtonColor;
        self.bottomGradientColor = [BKColors currentColors].cellButtonColor;
        
        self.titleColor = [BKColors currentColors].cellButtonFontColor;
        
        [self layoutTitle];
    }
    return self;
}

@end
