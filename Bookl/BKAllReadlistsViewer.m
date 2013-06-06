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

#pragma mark Tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadList *clickedReadlist = [self.readlists objectAtIndex:indexPath.row];
    [self showRightMenuForReadlist:clickedReadlist];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

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

#pragma mark TableHeaderDelegate
-(void)insertNewReadlist
{
    // open an alert with a textfield
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New ReadList" message:@"Enter readlist title"
                                                   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)toggleTableViewEdit
{
    NSLog(@"TOGGLE EDIT");
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

#pragma mark Navigation
-(void)showRightMenuForReadlist:(ReadList*)readlist
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    BKReadlistView *newReadlistView = [storyboard instantiateViewControllerWithIdentifier:@"ReadlistView"];
    newReadlistView.readlist = readlist;
    [[BKViewManager sharedViewManager] showRightMenu:newReadlistView];
}

@end
