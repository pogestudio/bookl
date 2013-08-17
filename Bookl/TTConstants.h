//
//  TTConstants.h
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ADVERTISEMENT_FREE_PAGES 4
#define PAGE_READ_IN_SECONDS 5
#define URL_BASE_ADDRESS @"https://secure.bookl.co"
#define URL_AMAZON @"https://s3.amazonaws.com/com.turtletail.java-bucket"

#define RIGHT_MENU_WIDTH 524

#define kAppDelegate (BKAppDelegate*)[UIApplication sharedApplication].delegate

@interface TTConstants : NSObject

+(NSString*)temporaryFilePath;

@end
