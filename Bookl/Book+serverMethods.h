//
//  Book+serverMethods.h
//  TurtleTail
//
//  Created by CA on 5/30/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "Book.h"
#import "BKProgressBarDelegate.h"

@interface Book (serverMethods)

@property (weak) id<BKProgressBarDelegate> progressDelegate;

-(id)initWithServerResults:(NSDictionary*)serverResults;

-(BOOL)isDownloaded;
-(void)downloadWithProgressBarDelegate:(id<BKProgressBarDelegate>)delegate;


@end
