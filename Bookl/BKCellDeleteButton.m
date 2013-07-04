//
//  BKCellDeleteButton.m
//  Bookl
//
//  Created by CA on 6/16/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKCellDeleteButton.h"

@implementation BKCellDeleteButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.topGradientColor = [BKColors currentColors].sharedBookDeleteButton;
        self.bottomGradientColor = [BKColors currentColors].sharedBookDeleteButton;
        
        self.titleColor = [BKColors currentColors].sharedBookDeleteButtonFont;
        
        [self layoutTitle];
    }
    return self;
}

@end
