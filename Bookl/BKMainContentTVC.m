//
//  BKMainContentTVC.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKMainContentTVC.h"

#import "BKLeftMenu.h"

@interface BKMainContentTVC ()

@end

@implementation BKMainContentTVC

+(id)fromStoryboard
{
    NSAssert(nil,@"should never call this");
    return nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.backgroundColor = [BKColors currentColors].mainCellBackground;
}
@end
