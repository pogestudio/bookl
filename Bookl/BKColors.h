//
//  BKColors.h
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+fromHex.h"

typedef enum {
    ColorSchemeINVALID = 0,
    ColorSchemeDark1,
    ColorSchemeLight1,
} ColorScheme;

@interface BKColors : NSObject

+(BKColors*)currentColors;
+(UIImage*)imageFromColor:(UIColor*)color;

#pragma mark Navbar
@property (strong) UIColor *navBarBackground;
@property (strong) UIColor *navBarFont;

#pragma mark UIBarButton
@property (strong) UIColor *barButtonBackground;
@property (strong) UIColor *barButtonPressedBackground;
@property (strong) UIColor *barButtonFont;

#pragma mark LeftMenu
@property (strong) UIColor *leftMenuCellBackground;
@property (strong) UIColor *leftMenuFont;

#pragma mark Toolbar
@property (strong) UIColor *toolBarBackground;

#pragma mark MiddleContent
@property (strong) UIColor *mainCellBackground;
@property (strong) UIColor *mainCellFont;
@property (strong) UIColor *mainCellDetailFont;


#pragma mark Tableview Header
@property (strong) UIColor *headerButtonBackground;
@property (strong) UIColor *headerButtonPressedBackground;
@property (strong) UIColor *headerButtonFont;

@property (strong) UIColor *mainTableviewHeaderBackground;

#pragma mark Searchbar
@property (strong) UIColor *searchBarBackground;

#pragma mark RightMenu
@property (strong) UIColor *rightMenuCellBackground;
@property (strong) UIColor *rightTableviewHeaderBackground;

#pragma mark SharedBookCell
@property (strong) UIColor *sharedBookCellButton;
@property (strong) UIColor *sharedBookCellButtonPressed;
@property (strong) UIColor *sharedBookCellButtonFont;
@property (strong) UIColor *sharedBookDeleteButton;
@property (strong) UIColor *sharedBookDeleteButtonPressed;
@property (strong) UIColor *sharedBookDeleteButtonFont;

#pragma mark MoreTVC
#pragma mark SettingsTVC
#pragma mark Login


@end
