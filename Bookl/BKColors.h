//
//  BKColors.h
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ColorSchemeINVALID = 0,
    ColorSchemeDark1,
    ColorSchemeDark2,
} ColorScheme;

@interface BKColors : NSObject

+(BKColors*)currentColors;
+(UIImage*)imageFromColor:(UIColor*)color;

#pragma mark Background Colors
@property (strong) UIColor *leftMenuCellBackground;
@property (strong) UIColor *mainCellBackground;
@property (strong) UIColor *rightMenuCellBackground;
@property (strong) UIColor *navigationBar;
@property (strong) UIColor *toolBar;

#pragma mark TableView ButtonColors
@property (strong) UIColor *buttonBackground;
@property (strong) UIColor *buttonFontColor;

#pragma mark CellView ButtonColors
@property (strong) UIColor *cellButtonColor;
@property (strong) UIColor *cellButtonFontColor;
@property (strong) UIColor *cellDeleteButtonColor;

#pragma mark UIBarButton
@property (strong) UIColor *barButtonBackground;
@property (strong) UIColor *barButtonPressedBackground;
@property (strong) UIColor *barButtonFontColor;


@end
