//
//  BKTokenFetch.h
//  Bookl
//
//  Created by CA on 6/17/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>

@interface BKTokenFetch : FBSessionTokenCachingStrategy

+(BKTokenFetch*)sharedInstance;

-(NSString*)currentFBUserToken;

@end
