//
//  TTSharedBookCell.h
//  TurtleTail
//
//  Created by CA on 5/29/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TTBook.h"
@class Book;

@interface TTSharedBookCell : UITableViewCell <ProgressBarDelegate>
{
    UIPopoverController  *_tempPop;
}

@property (strong) TTBook *theTTBook;
@property (strong) Book *theBook;
@property (strong) IBOutlet UILabel *rating;
@property (strong, nonatomic) IBOutlet UIButton *readButton;
@property (strong, nonatomic) IBOutlet UIStepper *ratingStepper;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UILabel *publishingYear;

- (IBAction)readButtonPressed:(id)sender;
-(void)setUpCellForBook:(id)book;

@end
