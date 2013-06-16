//
//  BKIAPManager.m
//  Bookl
//
//  Created by CA on 6/16/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKIAPManager.h"

@implementation BKIAPManager


+ (BKIAPManager *)sharedInstance {
    static dispatch_once_t once;
    static BKIAPManager * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.pogestudio.bookl.onemonthwithoutads",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
