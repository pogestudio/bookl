//
//  SKProduct+LocalizedPrice.h
//  Bookl
//
//  Created by CA on 6/12/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <StoreKit/StoreKit.h>

@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end
