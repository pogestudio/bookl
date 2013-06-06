//
//  BKAllReadlistsTVHeader.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReadlistsHeaderDelegate <NSObject>

-(void)insertNewReadlist;
-(void)toggleTableViewEdit;

@end

@interface BKAllReadlistsTVHeader : UIViewController

@property (weak) id<ReadlistsHeaderDelegate> headerDelegate;

@end
