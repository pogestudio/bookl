//
//  BKSettingsTVC.m
//  Bookl
//
//  Created by CA on 6/10/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSettingsTVC.h"

#import "ATConnect.h"
#import "BKViewManager.h"
#import "BKUser.h"
#import "BKUserManager.h"

#import "PDKeychainBindings.h"

#define kLogoutSection 1

@interface BKSettingsTVC ()

@end

@implementation BKSettingsTVC

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

#pragma mark - Table view data source

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if logout, then just do that
    if (indexPath.section == kLogoutSection) {
        [[BKUserManager sharedInstance] logoutUser];
        [self dismissPopup];
        return;
    }
    
    NSAssert(indexPath.section != kLogoutSection,@"wrong logic in didselectrow");
    switch (indexPath.row) {
        case 0: //feedback
        {
            UIViewController *viewManager = [BKViewManager sharedViewManager];
            ATConnect *connection = [ATConnect sharedConnection];
            [connection presentFeedbackControllerFromViewController:viewManager];
            [self dismissPopup];
            break;
        }
        case 1:
        {
            //IAP
            break;
        }
        case 2:
        {
          //random. What here?
            break;
        }
        default:
            NSAssert(nil,@"Should never be here, something is wrong with didSelectRow in class Settings");
            break;
    }
}

-(void)dismissPopup
{
    [self.popController dismissPopoverAnimated:YES];
}

#pragma mark Tableview Datasource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != kLogoutSection) {
        return;
    }
    
    NSString *displayName = [[PDKeychainBindings sharedKeychainBindings] objectForKey:@"display_name"];
    if (!displayName) {
        displayName = @"";
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Logout %@",displayName];
}

@end
