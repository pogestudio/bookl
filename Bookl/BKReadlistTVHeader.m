//
//  BKReadlistHeader.m
//  Bookl
//
//  Created by CA on 6/6/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKReadlistTVHeader.h"

@interface BKReadlistTVHeader ()

@end

@implementation BKReadlistTVHeader


-(IBAction)editReadlists:(id)sender
{
    UIButton *senderButton = (UIButton*)sender;
    
    BOOL didEnterEditingMode = [self.headerDelegate toggleTableViewEditWhichDidEnterEditingMode];
    if (didEnterEditingMode) {
        [senderButton setTitle:@"Done" forState:UIControlStateNormal];
    } else {
        [senderButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
}

@end
