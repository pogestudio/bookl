//
//  BKInAppPurchaseManager.m
//  Bookl
//
//  Created by CA on 6/12/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKInAppPurchaseManager.h"

@implementation BKInAppPurchaseManager

- (void)requestIAP
{
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.pogestudio.bookl.onemonthwithoutads" ];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    adRemoval = [products count] == 1 ? [products objectAtIndex:0] : nil;
    if (adRemoval)
    {
        NSLog(@"Product title: %@" , adRemoval.localizedTitle);
        NSLog(@"Product description: %@" , adRemoval.localizedDescription);
        NSLog(@"Product price: %@" , adRemoval.price);
        NSLog(@"Product id: %@" , adRemoval.productIdentifier);
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}

@end
