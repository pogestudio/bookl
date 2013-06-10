//
//  BKAllReadlistsTVHeader.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKAllReadlistsTVHeader.h"

@interface BKAllReadlistsTVHeader ()

@end

@implementation BKAllReadlistsTVHeader

-(IBAction)newReadlist:(id)sender
{
    [self.headerDelegate insertNewReadlist];

}

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
