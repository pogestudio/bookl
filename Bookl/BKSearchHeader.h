//
//  BKSearchHeader.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TTReadList.h"

@interface BKSearchHeader : UIViewController <UISearchBarDelegate,TTReadListDelegate>
{
    NSMutableDictionary *_watchlist;
    NSDate *_dateOfLastDeliveredReadlist;
}

@property (weak) id<TTReadListDelegate> readListDelegate;

@end
