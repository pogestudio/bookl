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
        
#pragma mark Background Colors
        self.leftMenuCellBackground = [UIColor greenColor];
        self.mainCellBackground = [UIColor yellowColor];
        self.rightMenuCellBackground = [UIColor greenColor];
    

#pragma mark TableView ButtonColors
        self.buttonBackground = [UIColor brownColor];
        self.buttonFontColor = [UIColor whiteColor];

#pragma mark CellView ButtonColors
        self.cellButtonColor = [UIColor lightGrayColor];
        self.cellButtonFontColor = [UIColor blackColor];
        self.cellDeleteButtonColor = [UIColor redColor];
        
#pragma mark UIBarButton
        self.barButtonBackground = [UIColor redColor];
        self.barButtonPressedBackground = [UIColor greenColor];
        self.navigationBar = [UIColor blueColor];
        self.toolBar = [UIColor darkGrayColor];
        //self.barButtonFontColor;

    }
    
    return self;
}


@end
