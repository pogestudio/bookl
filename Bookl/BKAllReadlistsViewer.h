//
//  BKAllReadlistsViewer.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BKMainContentTVC.h"
#import "BKAllReadlistsTVHeader.h"

@interface BKAllReadlistsViewer : BKMainContentTVC <ReadlistsHeaderDelegate>

@property (strong, nonatomic) NSArray *readlists;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) BKAllReadlistsTVHeader *tableHeader;

@end
