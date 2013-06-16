//
//  BKInAppPurchaseManager.m
//  Bookl
//
//  Created by CA on 6/12/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKIAPHelper.h"
#import "SKProduct+LocalizedPrice.h"
#import "NSDate+Compare.h"

#define kTransactionDateKey @"transactionDate"


NSString *const IAPHelperProductPurchasedNotification = @"IAPHelperProductPurchasedNotification";

// 2
@interface BKIAPHelper () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation BKIAPHelper

{
    SKProductsRequest * _productsRequest;
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        
        
        for (NSString * productIdentifier in _productIdentifiers) {
            
            BOOL productPurchased = [self oneMonthPurchaseIsValidForIdentifier:productIdentifier];
            
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    // 1
    _completionHandler = [completionHandler copy];
    
    // 2
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %@",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.localizedPrice);
    }
    
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

- (BOOL)productPurchased:(NSString *)productIdentifier {
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

- (void)buyProduct:(SKProduct *)product {
    
    NSLog(@"Buying %@...", product.productIdentifier);
    
    SKPayment * payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction * transaction in transactions) {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    };
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"completeTransaction...");
    
    [self savePurchaseDateForTransaction:transaction];
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];

}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"restoreTransaction...");
    
    [self savePurchaseDateForTransaction:transaction.originalTransaction];
    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    
    NSLog(@"failedTransaction...");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSLog(@"Transaction error: %@", transaction.error.localizedDescription);
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)provideContentForProductIdentifier:(NSString *)productIdentifier {
    
    [_purchasedProductIdentifiers addObject:productIdentifier];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:IAPHelperProductPurchasedNotification object:productIdentifier userInfo:nil];
    
}

- (void)restoreCompletedTransactions {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark Ad stuff
-(BOOL)oneMonthPurchaseIsValidForIdentifier:(NSString*)productIdentifier
{
    BOOL isValid = NO;
    NSString *transKey = [self transactionDateKeyForIdentifier:productIdentifier];
    NSDate *dateOfTransaction = [[NSUserDefaults standardUserDefaults] objectForKey:transKey];
    NSTimeInterval thirtyDays = 3600*24*30;
    if (dateOfTransaction && [[dateOfTransaction dateByAddingTimeInterval:thirtyDays] isLaterThanOrEqualTo:[NSDate date]])
    {
        isValid = YES;
    }
    return isValid;
}

-(void)savePurchaseDateForTransaction:(SKPaymentTransaction*)transaction
{
    NSString *transKey = [self transactionDateKeyForIdentifier:transaction.payment.productIdentifier];
    NSDate *dateOfPurchase = transaction.transactionDate;
    [[NSUserDefaults standardUserDefaults] setObject:dateOfPurchase forKey:transKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)transactionDateKeyForIdentifier:(NSString*)productIdentifier
{
    NSString *newKey = [NSString stringWithFormat:@"%@%@",kTransactionDateKey,productIdentifier];
    return newKey;
}
@end