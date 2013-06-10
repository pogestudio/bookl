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

#define CONTENT_X_PADDING 5
#define CONTENT_Y_PADDING 5
#define EDGE_PADDING 20


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
    
    
    [self setUpReadButton];
}

-(void)setUpReadButton
{
    if ([self.theTTBook isDownloaded] || [self.theBook isDownloaded]) {
        [self.readButton setTitle:@"Read" forState:UIControlStateNormal];
    }
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

#pragma mark Layout
-(void)layoutSubviews
{
    CGFloat edgePadding = EDGE_PADDING; // self.isEditing ? EDGE_PADDING * 2 : EDGE_PADDING;
    
    //layout moreButton
    CGFloat startingPoint = self.frame.size.width;
    [self layoutViews:@[self.moreButton] withEdgeAt:startingPoint - edgePadding];
    //readbutton
    [self layoutViews:@[self.readButton] withEdgeAt:self.moreButton.frame.origin.x];
    
    //layout title, author and year
    NSArray *tripleViews = [NSArray arrayWithObjects:self.title,self.author,self.publishingYear, nil];
    CGFloat edge = self.readButton.frame.origin.x;
    CGFloat widthForLabel = edge - edgePadding;
    CGRect newFrame = CGRectMake(0, 0, widthForLabel, self.frame.size.height);
    self.title.frame = newFrame;
    self.author.frame = newFrame;
    self.publishingYear.frame = newFrame;
    [self layoutViews:tripleViews withEdgeAt:self.readButton.frame.origin.x];
}

-(void)layoutViews:(NSArray*)views withEdgeAt:(CGFloat)rightEdge
{
    CGFloat xPadding = CONTENT_X_PADDING;
    CGFloat yPadding = CONTENT_Y_PADDING;
    
    CGFloat cellHeight = self.frame.size.height;
    
    for (NSUInteger viewIndex = 0; viewIndex < [views count]; viewIndex ++) {
        UIView *view = views[viewIndex];
        CGFloat viewWidth = view.frame.size.width;
        CGFloat viewHeight = (cellHeight - ([views count] + 1) * yPadding) / [views count];
        CGFloat viewXPos = rightEdge - viewWidth - xPadding;
        CGFloat viewYPos = (viewIndex + 1) * yPadding + viewIndex * viewHeight;
        CGRect newFrame = CGRectMake(viewXPos, viewYPos, viewWidth, viewHeight);
        view.frame = newFrame;
        //NSLog(@"%@",view);
    }
}

-(void)willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState:state];
    CGRect currentContentFrame = self.contentView.frame;
    CGRect currentViewFrame = self.frame;
    CGRect newFrame = [self cellRectForState:state];
    CGRect editingFrame = [self editAccessoryViewForState:state];
    switch (state) {
        case UITableViewCellStateDefaultMask:
        {
            self.moreButton.hidden = NO;
            break;
        }
        case UITableViewCellStateShowingEditControlMask:
        {
            self.moreButton.hidden = YES;
            
            break;
        }
        case UITableViewCellStateShowingDeleteConfirmationMask:
        {
            self.moreButton.hidden = YES;
            
            break;
        }
        default:
            NSAssert(nil, @"Should never be here. Wrong cell mask!");
            break;
    }
    
    [UIView animateWithDuration:0.5 animations:^(void){
        self.contentView.frame = newFrame;
        self.accessoryView.frame = editingFrame;
    }];

}

-(void)didTransitionToState:(UITableViewCellStateMask)state
{
    
    [super didTransitionToState:state];
    
    CGRect currentFrame = self.contentView.frame;
    switch (state) {
        case UITableViewCellStateDefaultMask:
        {
            //hide default button
            //show more button
            self.editingAccessoryView.hidden = YES;
            break;
        }
        case UITableViewCellStateShowingEditControlMask:
        {
            self.editingAccessoryView.hidden = NO;
            break;
        }
        case UITableViewCellStateShowingDeleteConfirmationMask:
        {
            self.editingAccessoryView.hidden = NO;
            NSLog(@"deleting");
            //self.moreButton.hidden = YES;
            
            break;
        }
        default:
            NSAssert(nil, @"Should never be here. Wrong cell mask!");
            break;
    }
    //self.contentView.frame = newFrame;
    
}

-(CGRect)cellRectForState:(UITableViewCellStateMask)state
{
    CGRect frame;
    switch (state) {
        case UITableViewCellStateDefaultMask:
        {
            //hide default button
            //show more button
            
            //get frame with frame width but content height
            CGRect regFrame = self.frame;
            CGRect contFrame = self.contentView.frame;
            frame = CGRectMake(regFrame.origin.x, contFrame.origin.y, regFrame.size.width, regFrame.size.height);
            break;
        }
        case UITableViewCellStateShowingEditControlMask:
        {
            NSLog(@"Showing delete control");
            frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width - self.editingAccessoryView.frame.size.width,self.contentView.frame.size.height);
            break;
        }
        case UITableViewCellStateShowingDeleteConfirmationMask:
        {
            NSLog(@"deleting");
            frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width - self.editingAccessoryView.frame.size.width,self.frame.size.height);
            
            break;
        }
        default:
            NSAssert(nil, @"Should never be here. Wrong cell mask!");
            break;
    }
    return frame;
}

-(CGRect)editAccessoryViewForState:(UITableViewCellStateMask)state
{
    self.editingAccessoryView.frame = self.moreButton.frame;
    CGRect frame;
    switch (state) {
        case UITableViewCellStateDefaultMask:
        {
            frame = CGRectZero;
            break;
        }
        case UITableViewCellStateShowingEditControlMask:
        {
            CGFloat xPos = self.contentView.frame.size.width - self.editingAccessoryView.frame.size.width;
            CGFloat yPos = (self.contentView.frame.size.height - self.editingAccessoryView.frame.size.height) / 2.0;
            frame = CGRectMake(xPos, yPos, self.editingAccessoryView.frame.size.width,self.editingAccessoryView.frame.size.height);
            break;
        }
        case UITableViewCellStateShowingDeleteConfirmationMask:
        {
            NSLog(@"deleting");
            CGFloat xPos = self.contentView.frame.size.width;
            CGFloat yPos = (self.contentView.frame.size.height - self.editingAccessoryView.frame.size.height) / 2.0;
            frame = CGRectMake(xPos, yPos, self.editingAccessoryView.frame.size.width,self.editingAccessoryView.frame.size.height);
            break;
        }
        default:
            NSAssert(nil, @"Should never be here. Wrong cell mask!");
            break;
    }
    return frame;
}

-(IBAction)deleteButtonPressed:(id)sender
{
    [self.delegate deleteCellAndItsData:self];
}
@end
