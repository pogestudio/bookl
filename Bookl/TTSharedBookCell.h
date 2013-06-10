//
//  TTSharedBookCell.h
//  TurtleTail
//
//  Created by CA on 5/29/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TTBook.h"
@class TTSharedBookCell;

@protocol SharedBookCellDelegate <NSObject>

-(void)deleteCellAndItsData:(TTSharedBookCell*)cell;
@end

@class Book;

@interface TTSharedBookCell : UITableViewCell <ProgressBarDelegate>
{
    UIPopoverController  *_tempPop;
}

@property (strong) TTBook *theTTBook;
@property (strong) Book *theBook;
@property (strong, nonatomic) IBOutlet UIButton *readButton;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UILabel *publishingYear;

//for delete purposes. Has to be set if you want to get the call to TableVC
@property (weak) id<SharedBookCellDelegate> delegate;

- (IBAction)readButtonPressed:(id)sender;
-(void)setUpCellForBook:(id)book;

@end
