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

-(void)setUpBookCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    NSAssert([cell isKindOfClass:[TTSharedBookCell class]],@"wrong class for bookCell");
    TTSharedBookCell *bookCell = (TTSharedBookCell*)cell;
    TTBook *bookForCell = [self.readlist.books objectAtIndex:indexPath.row];
    [bookCell setUpCellForBook:bookForCell];
}

#pragma mark ProgressBar Delegate
-(void)readListFinishedDowloading:(TTReadList *)readlist
{
    self.readlist = readlist;
    [self.tableView reloadData];
}
@end
