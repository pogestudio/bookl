//
//  TTMoreOptionsTVC.m
//  TurtleTail
//
//  Created by CA on 6/2/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTMoreOptionsTVC.h"

#import "TTBook.h"
#import "Book.h"

#import "TTAddBookToReadlist.h"

@interface TTMoreOptionsTVC ()

@end

@implementation TTMoreOptionsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Storyboard
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddBookToReadList"]) {
        TTAddBookToReadlist *receiver =(TTAddBookToReadlist*)segue.destinationViewController;
        receiver.popController = self.popController;
        if (self.TTBookTouse) {
            receiver.TTBookTouse = self.TTBookTouse;
        } else if (self.bookTouse) {
            receiver.bookTouse = self.bookTouse;
        } else {
            NSAssert(nil, @"Something is wrong, should always have a book ready at this point");
        }

    }
}

@end
