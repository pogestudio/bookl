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
        self.barButtonFont = [UIColor colorFromHex:0x4c5785];
        
#pragma mark LeftMenu
        self.leftMenuCellBackground = [UIColor colorFromHex:0x6574b2];
        self.leftMenuFont = [UIColor lightGrayColor];
        
#pragma mark Toolbar
        self.toolBarBackground = [UIColor colorFromHex:0x11112C];
        
#pragma mark MiddleContent
        self.mainCellBackground = [UIColor colorFromHex:0x6e7bb2];
        self.mainCellFont = [UIColor blackColor];
        self.mainCellDetailFont = [UIColor blackColor];
        
#pragma mark Tableview Header
        self.headerButtonBackground = [UIColor colorFromHex:0x60a235];
        self.headerButtonPressedBackground = [UIColor colorFromHex:0x94d36c];
        self.headerButtonFont = [UIColor colorFromHex:0x4d5c98];
        self.mainTableviewHeaderBackground = [UIColor clearColor];
        
#pragma mark Searchbar
        self.searchBarBackground = self.mainCellBackground;
        
#pragma mark RightMenu
        self.rightMenuCellBackground = [UIColor colorFromHex:0x669cae];
        self.rightTableviewHeaderBackground = [UIColor clearColor];
        
#pragma mark SharedBookCell
        self.sharedBookCellButton = [UIColor colorFromHex:0xbe61a2];
        self.sharedBookCellButtonPressed = [UIColor colorFromHex:0xbe6ca5];
        self.sharedBookCellButtonFont = [UIColor blackColor];
        self.sharedBookDeleteButton = [UIColor colorFromHex:0xdf6262];
        self.sharedBookDeleteButtonPressed = [UIColor colorFromHex:0x11112C];
        self.sharedBookDeleteButtonFont = [UIColor blackColor];
        
        
    }
    
    return self;
}


@end
