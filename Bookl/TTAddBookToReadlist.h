//
//  TTAddBookToReadlist.h
//  TurtleTail
//
//  Created by CA on 6/2/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Book;
@class TTBook;

@interface TTAddBookToReadlist : UITableViewController

@property (strong) NSArray *readlistsForUser;

@property (strong) Book *bookTouse;
@property (strong) TTBook *TTBookTouse;
@property (weak) UIPopoverController *popController;

@end
