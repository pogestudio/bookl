//
//  BKAllReadlistsViewer.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKAllReadlistsViewer.h"

#import "ReadList.h"
#import "TTCoreDataFactory.h"
#import "BKAppDelegate.h"
#import "BKViewManager.h"
#import "BKReadlistView.h"
#import "BKSlidingViewController.h"

@interface BKAllReadlistsViewer ()

@end

@implementation BKAllReadlistsViewer

+(id)fromStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    id vc = [storyboard instantiateViewControllerWithIdentifier:@"AllReadlistsView"];
    return vc;
}

#pragma mark Standard Stuff
-(void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.tableHeader) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
        self.tableHeader = [storyboard instantiateViewControllerWithIdentifier:@"AllReadlistsHeader"];
        self.tableHeader.headerDelegate = self;
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[BKSlidingViewController sharedInstance] changeNavConTitle:@"Readlists"];
}

#pragma mark Tableview Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadList *clickedReadlist = [self.readlists objectAtIndex:indexPath.row];
    [self showRightMenuForReadlist:clickedReadlist];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark Tableview Datasource

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
    [self fetchAllObjects];
    NSInteger sections = 1;
    return sections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [self.readlists count];
    return rows;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSAssert(NO, @"fix the height of the label, for some reason it's way off. Next up, load read list VC when clicked");
    //searchbar should always be shown
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ReadlistCell"];
    ReadList *readlistForCell = [self.readlists objectAtIndex:indexPath.row];
    cell.textLabel.text = readlistForCell.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%d)",[readlistForCell.books count]];
    return cell;
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
         ReadList *readListToDelete = self.readlists[indexPath.row];
         [self deleteReadlist:readListToDelete];
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
 }

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark TableHeaderDelegate
-(void)insertNewReadlist
{
    // open an alert with a textfield
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New ReadList" message:@"Enter readlist title"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(BOOL)toggleTableViewEditWhichDidEnterEditingMode
{
    NSLog(@"TOGGLE EDIT");
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    return self.tableView.isEditing;
}

#pragma mark UIAlerViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 1) {
        return; //cancel button
    }
    
    NSString *readlistName = [alertView textFieldAtIndex:0].text;
    [self addNewReadListWithTitle:readlistName];
    
}

#pragma mark Readlist Data
-(void)fetchAllObjects
{
    NSManagedObjectContext *moc = ((BKAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"ReadList" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // Set example predicate and sort orderings...
    
    //fetch logged in users stuff
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lastName LIKE[c] 'Worsley') AND (salary > %@)", minimumSalary];
    //[request setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"title" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }
    self.readlists = array;
}

- (void)addNewReadListWithTitle:(NSString*)title
{
    ReadList *newReadList = [[TTCoreDataFactory sharedFactory] newReadlist];
    newReadList.title = title;
    [((BKAppDelegate*)[UIApplication sharedApplication].delegate) saveContext];
    [self.tableView reloadData];
}

-(void)deleteReadlist:(ReadList*)readlistToDelete
{
    NSManagedObjectContext *moc = ((BKAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    for (NSManagedObject *bookInReadlist in readlistToDelete.books) {
        [moc deleteObject:bookInReadlist];
    }
    [moc deleteObject:readlistToDelete];
    [((BKAppDelegate*)[UIApplication sharedApplication].delegate) saveContext];
}

#pragma mark Navigation
-(void)showRightMenuForReadlist:(ReadList*)readlist
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    BKReadlistView *newReadlistView = [storyboard instantiateViewControllerWithIdentifier:@"ReadlistView"];
    newReadlistView.readlist = readlist;
    [[BKViewManager sharedViewManager] showRightMenu:newReadlistView];
}

@end
