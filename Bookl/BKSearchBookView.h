//
//  BKSearchBook.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKMainContentTVC.h"
#import "TTReadList.h"

@class BKSearchHeader;

@interface BKSearchBookView : BKMainContentTVC <TTReadListDelegate>

@property (strong) BKSearchHeader *searchHeader;
@property (strong) TTReadList *readlist;

@end
