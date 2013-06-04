//
//  BKLeftMenu.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKLeftMenu.h"
#import "BKViewManager.h"

@interface BKLeftMenu ()

@end

@implementation BKLeftMenu

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

@end
