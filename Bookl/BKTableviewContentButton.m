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
        self.topGradientColor = [BKColors currentColors].headerButtonBackground;
        self.bottomGradientColor = [BKColors currentColors].headerButtonBackground;
        
        self.titleColor = [BKColors currentColors].headerButtonFont;
        self.cornerRadius = 4.0;
        [self layoutTitle];
    }
    return self;
}


@end
