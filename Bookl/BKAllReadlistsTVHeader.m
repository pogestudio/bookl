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
    [self.headerDelegate toggleTableViewEdit];
}

@end
