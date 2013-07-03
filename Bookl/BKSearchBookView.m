//
//  BKSearchBook.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSearchBookView.h"
#import "BKSearchHeader.h"
#import "TTReadList.h"

#import "TTSharedBookCell.h"

#import "BKSlidingViewController.h"

@interface BKSearchBookView ()

@end

@implementation BKSearchBookView

+(id)fromStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    id vc = [storyboard instantiateViewControllerWithIdentifier:@"SearchBookView"];
    return vc;
}

-(void)viewDidLoad
{
    if (!self.searchHeader) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        self.searchHeader = [storyboard instantiateViewControllerWithIdentifier:@"SearchHeader"];
        self.searchHeader.readListDelegate = self;
    }
    
    UINib *sharedCell = [UINib nibWithNibName:@"TTSharedBookCell" bundle:nil];
    [self.tableView registerNib:sharedCell forCellReuseIdentifier:@"SharedBookCell"];


}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BKSlidingViewController sharedInstance] changeNavConTitle:@"Search"];
}

#pragma mark TableView Datasource
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchHeader.view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = self.searchHeader.view.frame.size.height;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTSharedBookCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SharedBookCell"];
    return cell.frame.size.height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [self.readlist.books count];
    return rows;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cellToSetUp = [tableView dequeueReusableCellWithIdentifier:@"SharedBookCell"];
    [self setUpBookCell:cellToSetUp forIndexPath:indexPath];
    return cellToSetUp;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.readlist.canDeliverMore == NO) {
        return;
    }
    
    if (indexPath.row + 1 >= [self.readlist.books count]) {
        NSLog(@"filling with more books :D:D");
        [self.readlist fillReadListWithMoreBooks];
        self.readlist.delegate = self;
    }
}

-(void)setUpBookCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    NSAssert([cell isKindOfClass:[TTSharedBookCell class]],@"wrong class for bookCell");
    TTSharedBookCell *bookCell = (TTSharedBookCell*)cell;
    TTBook *bookForCell = [self.readlist.books objectAtIndex:indexPath.row];
    [bookCell setUpCellForBook:bookForCell];
}

#pragma mark ProgressBar Delegate
-(void)readListFinishedDowloading:(TTReadList *)readlist fromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex
{
    //if it's 0-x, then replace all reading list. If not, replace the new range.
    if (startIndex == 0) {
        [self replaceWholeReadinglistWith:readlist toIndex:endIndex];
    } else {
        [self addBooksFrom:readlist fromIndex:startIndex toIndex:endIndex];
    }
}

-(void)replaceWholeReadinglistWith:(TTReadList*) newList toIndex:(NSUInteger)endIndex
{
    //make this one delete all rows, then insert new ones

    NSUInteger searchResultSecion = 0;
    
    NSMutableArray *currentIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *newIndexpaths = [[NSMutableArray alloc] init];
    
    NSUInteger row;
    for ( row = 0; row < [self.readlist.books count] ; row++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:searchResultSecion];
        [currentIndexPaths addObject:newIndexPath];
    }
    
    for (row = 0 ; row < [newList.books count] ; row++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:searchResultSecion];
        [newIndexpaths addObject:newIndexPath];
    }
    
    
    [self.tableView beginUpdates];
    self.readlist = nil;
    [self.tableView deleteRowsAtIndexPaths:currentIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    
    [self.tableView beginUpdates];
    self.readlist = newList;
    [self.tableView insertRowsAtIndexPaths:newIndexpaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(void)addBooksFrom:(TTReadList*) newList fromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex
{
    NSAssert(startIndex != 0,@"wrong startindex");
    //presumably, this should be the same lists
    
    //make this one delete all rows, then insert new ones
    
    NSUInteger searchResultSecion = 0;
    NSMutableArray *newIndexpaths = [[NSMutableArray alloc] init];
    
    for (NSUInteger row = startIndex ; row < endIndex ; row++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:row inSection:searchResultSecion];
        [newIndexpaths addObject:newIndexPath];
    }
    
    //Remove the old books so you can add them in tableview updates
    NSIndexSet *newBooksIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(startIndex, (endIndex-startIndex))];
    NSArray *newBooks = [newList.books objectsAtIndexes:newBooksIndexes];
    [self.readlist.books removeObjectsInArray:newBooks];
    
    [self.tableView beginUpdates];
    [self.readlist.books addObjectsFromArray:newBooks];
    [self.tableView insertRowsAtIndexPaths:newIndexpaths withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];

}


@end
