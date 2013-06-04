//
//  TTSharedBookCell.m
//  TurtleTail
//
//  Created by CA on 5/29/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTSharedBookCell.h"

#import "TTBookManager.h"
#import "TTMoreOptionsTVC.h"

#import "Book+serverMethods.h"
#import "Author.h"

@implementation TTSharedBookCell

- (IBAction)readButtonPressed:(id)sender {
    id bookToRead = self.theBook ? self.theBook : self.theTTBook;
    [[TTBookManager sharedManager] startReadingBook:bookToRead withProgressDelegate:self];
}

- (IBAction)moreButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    UINavigationController *navCon = [storyboard instantiateViewControllerWithIdentifier:@"MoreOptionsNavCon"];
    _tempPop = [[UIPopoverController alloc] initWithContentViewController:navCon];
    
    TTMoreOptionsTVC *moreOptions = [navCon.viewControllers lastObject];
    moreOptions.popController = _tempPop;
    
    if (self.theBook) {
        moreOptions.bookTouse = self.theBook;
    } else if (self.theTTBook)
    {
        moreOptions.TTBookTouse = self.theTTBook;
    } else {
        NSAssert(nil, @"should never be here. wrong setup of books");
    }
    
    
    UIView *viewToPresentIn = self.superview;
    NSAssert(viewToPresentIn != nil, @"superview is nil for popovercontroller");
    
    UIButton *senderButton = (UIButton*)sender;
    CGRect buttonRectInCell = senderButton.frame;
    CGRect buttonRectInSuperview = [self convertRect:buttonRectInCell toView:viewToPresentIn];
    
    
    [_tempPop presentPopoverFromRect:buttonRectInSuperview inView:viewToPresentIn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)setUpCellForBook:(id)book
{
    NSString *author;
    NSString *title;
    NSString *pubYear;
    
    if ([book isKindOfClass:[Book class]]) {
        self.theBook = (Book*)book;
        Author *bookAuthor = [[[self.theBook.authors objectEnumerator] allObjects] lastObject];
        author = bookAuthor.firstName;
        title = self.theBook.title;
        pubYear = [NSString stringWithFormat:@"%d",[self.theBook.publishingYear intValue]];
    } else if([book isKindOfClass:[TTBook class]])
    {
        self.theTTBook = (TTBook*)book;
        self.theTTBook.progressDelegate = self;
        author = self.theTTBook.author;
        title = self.theTTBook.title;
        pubYear = self.theTTBook.publishingYear;
    }  else {
        NSAssert(nil, @"should never be here. wrong setup of books");
    }
    
    self.author.text = author;
    self.title.text = title;
    self.publishingYear.text = pubYear;
    
    NSString *rating = @"5.0";
    self.rating = [NSString stringWithFormat:@"%@/10 - X",rating];
    
    [self setUpReadButton];
    [self setUpRatingCircle];
}

-(void)setUpReadButton
{
    if ([self.theTTBook isDownloaded] || [self.theBook isDownloaded]) {
        [self.readButton setTitle:@"Read" forState:UIControlStateNormal];
    }
}

-(void)setUpRatingCircle
{
    CGRect rectForPie = CGRectMake(0, 0, 40, 40);
    //TTRatingCirclePie *newCircle = [[TTRatingCirclePie alloc] initWithFrame:rectForPie];
    //[newCircle drawRect:rectForPie];
    //[self addSubview:newCircle];
}
#pragma mark ProgressBarDelegate
-(void)setProgressBarPercentage:(CGFloat)percentage
{
    NSString *buttonText;
    if (percentage < 1) {
        buttonText = [NSString stringWithFormat:@"%.02f%%",percentage];
    } else {
        buttonText = @"Read";
    }
    [self.readButton setTitle:buttonText forState:UIControlStateNormal];
}
@end
