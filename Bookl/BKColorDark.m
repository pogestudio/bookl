//
//  BKColorDark.m
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKColorDark.h"

@implementation BKColorDark

-(id)init
{
    self = [super init];
    if (self) {
#pragma mark Navbar
        self.navBarBackground = [UIColor colorFromHex:0x1B1B2F];
        self.navBarFont = [UIColor colorFromHex:0x11112C];
        
#pragma mark UIBarButton
        self.barButtonBackground = [UIColor colorFromHex:0x3D3D68];
        self.barButtonPressedBackground = [UIColor colorFromHex:0x11112C];
        self.barButtonFont = [UIColor colorFromHex:0x11112C];
        
#pragma mark LeftMenu
        self.leftMenuCellBackground = [UIColor colorFromHex:0x1C1C36];
        self.leftMenuFont = [UIColor lightGrayColor];
        
#pragma mark Toolbar
        self.toolBarBackground = [UIColor colorFromHex:0x11112C];
        
#pragma mark MiddleContent
        self.mainCellBackground = [UIColor colorFromHex:0x424268];
        self.mainCellFont = [UIColor colorFromHex:0x11112C];
        self.mainCellDetailFont = [UIColor colorFromHex:0x11112C];
        
#pragma mark Tableview Header
        self.headerButtonBackground = [UIColor colorFromHex:0x251934];
        self.headerButtonPressedBackground = [UIColor colorFromHex:0x11112C];
        self.headerButtonFont = [UIColor whiteColor];
        self.mainTableviewHeaderBackground = [UIColor clearColor];
        
#pragma mark Searchbar
        self.searchBarBackground = self.mainCellBackground;
        
#pragma mark RightMenu
        self.rightMenuCellBackground = self.leftMenuCellBackground;
        self.rightTableviewHeaderBackground = [UIColor clearColor];
        
#pragma mark SharedBookCell
        self.sharedBookCellButton = [UIColor colorFromHex:0x375165];
        self.sharedBookCellButtonPressed = [UIColor colorFromHex:0x11112C];
        self.sharedBookCellButtonFont = [UIColor lightGrayColor];
        self.sharedBookDeleteButton = [UIColor colorFromHex:0xb83d3d];
        self.sharedBookDeleteButtonPressed = [UIColor colorFromHex:0x11112C];
        self.sharedBookDeleteButtonFont = [UIColor colorFromHex:0x11112C];
        

    }
    
    return self;
}


@end
