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

@interface BKLeftMenu ()

@property (strong) UIPopoverController *settingsPopover;

@end

@implementation BKLeftMenu


-(void)viewDidLoad
{

    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if( [segue isKindOfClass:[UIStoryboardPopoverSegue class]] )
    {
        UIStoryboardPopoverSegue *popoverSegue      = (id)segue;
        UIPopoverController      *popoverController = popoverSegue.popoverController;
        
        if( self.settingsPopover.popoverVisible )
        {
            [self.settingsPopover dismissPopoverAnimated:NO];
            dispatch_async( dispatch_get_main_queue(), ^{
                [popoverController dismissPopoverAnimated:YES];
            });
            self.settingsPopover = nil;
        }
        else
        {
            self.settingsPopover = popoverController;
        }
    }
}

-(void)dealloc
{
    if( self.settingsPopover.popoverVisible )
    {
        [self.settingsPopover dismissPopoverAnimated:YES];
    }
}

@end
