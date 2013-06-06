//
//  BKReadlistView.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKReadlistView.h"
#import "ReadList.h"
#import "TTSharedBookCell.h"

#import "TTConstants.h"

@interface BKReadlistView ()

@end

@implementation BKReadlistView


#pragma mark Standard
-(void)viewDidLoad
{
    [super viewDidLoad];
    UINib *sharedCell = [UINib nibWithNibName:@"TTSharedBookCell" bundle:nil];
    [self.tableView registerNib:sharedCell forCellReuseIdentifier:@"SharedBookCell"];
}

#pragma mark TableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = 1;
    return sections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [self.readlist.books count];
    return rows;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTSharedBookCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SharedBookCell"];
    Book *bookForCell = [self.readlist.books objectAtIndex:indexPath.row];
    [cell setUpCellForBook:bookForCell];
    
    CGRect newFrame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, RIGHT_MENU_WIDTH, cell.frame.size.height);
    cell.frame = newFrame;
    return cell;
}

#pragma mark Tableview Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
