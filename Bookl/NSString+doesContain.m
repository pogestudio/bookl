//
//  NSString+doesContain.m
//  Bookl
//
//  Created by CA on 6/27/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "NSString+doesContain.h"

@implementation NSString (doesContain)
-(BOOL)doesContain:(NSString *)characters
{
    BOOL doesContain = NO;
    if ([self rangeOfString:characters].location != NSNotFound){
        doesContain = YES;
    }
    
    return doesContain;
}

@end
