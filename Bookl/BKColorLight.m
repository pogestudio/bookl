//
//  BKColorLight.m
//  Bookl
//
//  Created by CA on 6/16/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKColorLight.h"

@implementation BKColorLight

-(id)init
{
    self = [super init];
    if (self) {
#pragma mark Navbar
        self.navBarBackground = [UIColor colorFromHex:0x303f7d];
        self.navBarFont = [UIColor whiteColor];
        
#pragma mark UIBarButton
        self.barButtonBackground = [UIColor colorFromHex:0x79ac57];
        self.barButtonPressedBackground = [UIColor colorFromHex:0x9bd377];
        self.barButtonFont = self.navBarBackground;
        
#pragma mark LeftMenu
        self.leftMenuCellBackground = [UIColor colorFromHex:0x6574b2];
        self.leftMenuFont = [UIColor colorFromHex:0x142959];
        
#pragma mark Toolbar
        self.toolBarBackground = self.leftMenuCellBackground;
        
#pragma mark MiddleContent
        self.mainCellBackground = [UIColor colorFromHex:0x6e7bb2];
        self.mainCellFont = [UIColor blackColor];
        self.mainCellDetailFont = [UIColor blackColor];
        
#pragma mark Tableview Header
        self.headerButtonBackground = [UIColor colorFromHex:0x8cb2eb];
        self.headerButtonPressedBackground = [UIColor whiteColor];
        self.headerButtonFont = [UIColor blackColor];
        self.mainTableviewHeaderBackground = [UIColor clearColor];
        
#pragma mark Searchbar
        self.searchBarBackground = self.mainCellBackground;
        
#pragma mark RightMenu
        self.rightMenuCellBackground = [UIColor colorFromHex:0x7b85b2];
        self.rightTableviewHeaderBackground = [UIColor clearColor];
        
#pragma mark SharedBookCell
        self.sharedBookCellButton = [UIColor colorFromHex:0xdfca62];
        self.sharedBookCellButtonPressed = [UIColor colorFromHex:0xbe6ca5];
        self.sharedBookCellButtonFont = [UIColor blackColor];
        self.sharedBookDeleteButton = [UIColor colorFromHex:0xdf6662];
        self.sharedBookDeleteButtonPressed = [UIColor redColor];
        self.sharedBookDeleteButtonFont = [UIColor blackColor];
    }
    
    return self;
}


@end
