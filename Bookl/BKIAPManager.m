//
//  BKIAPManager.m
//  Bookl
//
//  Created by CA on 6/16/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKIAPManager.h"
#import "NSDate+Compare.h"

#define kAdRemovalIdentifier @"com.pogestudio.bookl.onemonthwithoutads"

@implementation BKIAPManager


+ (BKIAPManager *)sharedInstance {
    static dispatch_once_t once;
    static BKIAPManager * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      kAdRemovalIdentifier,
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

-(BOOL)adRemovalIsValid
{
    BOOL isValid = [self oneMonthPurchaseIsValidForIdentifier:kAdRemovalIdentifier];
    return isValid;
}


@end
