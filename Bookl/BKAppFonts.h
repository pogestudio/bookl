//
//  BKFonts.h
//  Bookl
//
//  Created by CA on 6/22/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BKAppFonts : NSObject

/*
 
 #pragma mark Navbar
 @property (strong) UIColor *navBarBackground;
 @property (strong) UIColor *navBarFont;
 
 */

@property (strong) UIFont *navBarFont;

/*
 
 #pragma mark UIBarButton
 @property (strong) UIColor *barButtonBackground;
 @property (strong) UIColor *barButtonPressedBackground;
 @property (strong) UIColor *barButtonFont;
 
 */

@property (strong) UIFont *barButtonFont;


/*
 #pragma mark LeftMenu
 @property (strong) UIColor *leftMenuCellBackground;
 @property (strong) UIColor *leftMenuFont;
 */

@property (strong) UIFont *leftMenuFont;

/*
 #pragma mark Tableview Header
 @property (strong) UIColor *headerButtonBackground;
 @property (strong) UIColor *headerButtonPressedBackground;
 @property (strong) UIColor *headerButtonFont;
 */

@property (strong) UIFont *tableViewHeaderButtonFont;


/*
 
 #pragma mark Searchbar
 @property (strong) UIColor *searchBarBackground;
 */


/* #pragma mark SharedBookCell
 @property (strong) UIColor *sharedBookCellButton;
 @property (strong) UIColor *sharedBookCellButtonPressed;
 @property (strong) UIColor *sharedBookCellButtonFont;
 
 */

@property (strong) UIFont *sharedBookCellFont;
/*
 @property (strong) UIColor *sharedBookDeleteButton;
 @property (strong) UIColor *sharedBookDeleteButtonPressed;
 @property (strong) UIColor *sharedBookDeleteButtonFont;
*/


@end
