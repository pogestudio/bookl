//
//  NSDate+PdfUrlIsValid.m
//  Bookl
//
//  Created by CA on 6/30/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "NSDate+PdfUrlIsValid.h"

@implementation NSDate (PdfUrlIsValid)

-(BOOL)pdfUrlIsValid
{
    NSTimeInterval limit = 3600*23; //limit is 23 hrs
    NSTimeInterval between = [self timeIntervalSinceNow];
    BOOL isEnough = limit > between;
    return isEnough;
}
@end
