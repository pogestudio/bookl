//
//  BKInAppPurchaseManager.h
//  Bookl
//
//  Created by CA on 6/12/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"

@interface BKInAppPurchaseManager : NSObject <SKProductsRequestDelegate>
{
    SKProduct *adRemoval;
    SKProductsRequest *productsRequest;
}

- (void)requestIAP;

@end
