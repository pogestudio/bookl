//
//  BKHTTPClient.h
//  Bookl
//
//  Created by CA on 6/20/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFJSONRequestOperation.h"

@interface BKHTTPClient : AFHTTPClient

+(BKHTTPClient *)sharedClient;

- (void)setUsername:(NSString *)username andPassword:(NSString *)password;

@end
