//
//  BKReadlistView.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKReadlistView.h"
#import "ReadList.h"
#import "Book.h"
#import "TTSharedBookCell.h"

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGFloat newXpos = self.view.frame.size.width - RIGHT_MENU_WIDTH;
    CGRect newFrame = CGRectMake(newXpos, self.view.frame.origin.y, RIGHT_MENU_WIDTH, self.view.frame.size.height);
    self.view.frame = newFrame;
    NSLog(@"View will appear, current width: %f",self.view.frame.size.width);
    
    if (!self.tableHeader) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        self.tableHeader = [storyboard instantiateViewControllerWithIdentifier:@"ReadlistTVHeader"];
        self.tableHeader.headerDelegate = self;
    }
    
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.backgroundColor = [UIColor blueColor];
}

#pragma mark TableView Datasource
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.tableHeader.view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableHeader.view.frame.size.height;
}

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
    cell.contentView.frame = newFrame;
    cell.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTSharedBookCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SharedBookCell"];
    return cell.frame.size.height;
}

#pragma mark Tableview Delegate
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Book *bookToDelete = self.readlist.books[indexPath.row];
        [self deleteBook:bookToDelete];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark Data Manipulation
-(void)deleteBook:(Book*)bookToDelete
{
    NSManagedObjectContext *moc = [kAppDelegate managedObjectContext];
    [moc deleteObject:bookToDelete];
    [kAppDelegate saveContext];
}


-(void)renameCurrentReadlistToName:(NSString*)name
{
    self.readlist.title = name;
    [kAppDelegate saveContext];
}

#pragma mark TableHeaderDelegate
-(BOOL)toggleTableViewEditWhichDidEnterEditingMode
{
    self.tableView.editing = !self.tableView.editing;
//    NSLog(@"TOGGLE EDIT: %@",self.isEditing ? @"ON" : @"OFF");
//    
//    CGRect theFrame = self.view.frame;
//    NSLog(@"View: %f - %f - %f - %f",theFrame.origin.x,theFrame.origin.y,theFrame.size.width,theFrame.size.height);
//    
//    theFrame = self.tableView.frame;
//    NSLog(@"Table: %f - %f - %f - %f",theFrame.origin.x,theFrame.origin.y,theFrame.size.width,theFrame.size.height);
//
//    theFrame = self.view.superview.frame;
//    NSLog(@"Superview: %f - %f - %f - %f",theFrame.origin.x,theFrame.origin.y,theFrame.size.width,theFrame.size.height);
//    
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    theFrame = cell.frame;
//    NSLog(@"Cell: %f - %f - %f - %f",theFrame.origin.x,theFrame.origin.y,theFrame.size.width,theFrame.size.height);
    
    return self.tableView.isEditing;
}

-(void)openReadlistRename
{
    // open an alert with a textfield
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rename readList" message:@"Enter readlist title"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = self.readlist.title;
    [alert show];
}

#pragma mark UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 1) {
        return; //cancel button
    }
    
    NSString *newName = [alertView textFieldAtIndex:0].text;
    [self renameCurrentReadlistToName:newName];
    
}



#pragma mark SharedBookCellDelegate
-(void)deleteCellAndItsData:(TTSharedBookCell *)cell
{
    NSIndexPath *IPOfCell = [self.tableView indexPathForCell:cell];
    [self tableView:self.tableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:IPOfCell];
}
@end
