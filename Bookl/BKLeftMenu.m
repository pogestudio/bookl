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
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self.viewManager presentNewVCOfType:TypeOfCurrentVCHome];
            break;
        }
        case 1:
        {
            [self.viewManager presentNewVCOfType:TypeOfCurrentVCSearchResult];
            break;
        }
        case 2:
        {
            [self.viewManager presentNewVCOfType:TypeOfCurrentVCReadList];
            break;
        }
            
        default:
            break;
    }
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if( [segue isKindOfClass:[UIStoryboardPopoverSegue class]] )
//    {
//        UIStoryboardPopoverSegue *popoverSegue      = (id)segue;
//        UIPopoverController      *popoverController = popoverSegue.popoverController;
//        
//        if( self.settingsPopover.popoverVisible )
//        {
//            [self.settingsPopover dismissPopoverAnimated:NO];
//            dispatch_async( dispatch_get_main_queue(), ^{
//                [popoverController dismissPopoverAnimated:YES];
//            });
//            self.settingsPopover = nil;
//        }
//        else
//        {
//            self.settingsPopover = popoverController;
//        }
//        
//        //if it's the settings, give it the popovercontroller so it can dismiss itsel when pressed
//        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
//            if ([[((UINavigationController*)segue.destinationViewController).viewControllers lastObject] isKindOfClass:[BKSettingsTVC class]]) {
//                BKSettingsTVC *settings = [((UINavigationController*)segue.destinationViewController).viewControllers lastObject];
//                settings.popController = ((UIStoryboardPopoverSegue*)segue).popoverController;
//            }
//        }
//    }
//    
//}

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
