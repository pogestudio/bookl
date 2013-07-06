//
//  BKLeftMenu.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKLeftMenu.h"
#import "BKViewManager.h"
#import "BKSettingsTVC.h"
#import "UIBarButtonItem+customInit.h"

@interface BKLeftMenu ()
{
    UIPopoverController *_tempPop;
    NSIndexPath *_lastPressedRow;
    
}

@property (strong) UIPopoverController *settingsPopover;

@end

@implementation BKLeftMenu


-(void)viewDidLoad
{
    UIBarButtonItem *settings = [UIBarButtonItem barItemWithTitle:@"Settings" target:self action:@selector(showSettings:)];
    
//    NSArray *currentItems = self.navigationController.tool
    NSArray *items = @[settings];
    [self setToolbarItems:items];
    self.tableView.backgroundColor = [BKColors currentColors].leftMenuCellBackground;
    
    _lastPressedRow = [NSIndexPath indexPathForRow:1 inSection:0]; //simulate pressed readlist button
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _lastPressedRow.row && indexPath.section == _lastPressedRow.section) {
        //pressed same as before. bail out
        return;
    } else {
        _lastPressedRow = indexPath;
    }
    switch (indexPath.row) {
//        case 0:
//        {
//            [self.viewManager presentNewVCOfType:TypeOfCurrentVCHome];
//            break;
//        }
        case 0:
        {
            [self.viewManager presentNewVCOfType:TypeOfCurrentVCSearchResult];
            break;
        }
        case 1:
        {
            [self.viewManager presentNewVCOfType:TypeOfCurrentVCReadList];
            break;
        }
            
        default:
            NSAssert(nil,@"Should never be here, something is wrong with didSelectCell in class leftMenu");
            break;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.textLabel setTextColor:[BKColors currentColors].leftMenuFont];
}

-(void)showSettings:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    UINavigationController *navCon = [storyboard instantiateViewControllerWithIdentifier:@"SettingsNavCon"];
    _tempPop = [[UIPopoverController alloc] initWithContentViewController:navCon];
    
    BKSettingsTVC *settings = [navCon.viewControllers lastObject];
    settings.popController = _tempPop;
    
    UIView *viewToPresentIn = self.view;
    NSAssert(viewToPresentIn != nil, @"view is nil for popovercontroller");
    
    UIButton *senderButton = (UIButton*)sender;
    CGRect buttonRect = senderButton.frame;
    UIView *viewForButton = senderButton.superview;
    CGRect windowRectForButton = [self.view convertRect:buttonRect fromView:viewForButton];
    [_tempPop presentPopoverFromRect:windowRectForButton inView:viewToPresentIn permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

@end
