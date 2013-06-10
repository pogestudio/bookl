//
//  BKReadlistHeader.h
//  Bookl
//
//  Created by CA on 6/6/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReadlistHeaderDelegate <NSObject>

-(BOOL)toggleTableViewEditWhichDidEnterEditingMode;

@end


@interface BKReadlistTVHeader : UIViewController

@property (weak) id<ReadlistHeaderDelegate> headerDelegate;

@end
