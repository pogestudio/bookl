//
//  BKColors.m
//  Bookl
//
//  Created by CA on 6/15/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKColors.h"
#import "BKColorDark.h"

#define CURRENT_SCHEME 1

static ColorScheme _lastInitType;
static BKColors *_lastInit;

@implementation BKColors

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+(BKColors*)currentColors
{
    BKColors *currentColors;
    switch (CURRENT_SCHEME) {
        case ColorSchemeDark1:
        {
            if (_lastInitType == ColorSchemeDark1 && _lastInit) {
                currentColors = _lastInit;
            } else {
                currentColors = [[BKColorDark alloc] init];
            }
            break;
        }
        default:
            NSAssert(nil, @"wrong color scheme");
            break;
    }
    _lastInit = currentColors;
    return currentColors;
}


@end
