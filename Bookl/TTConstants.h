//
//  TTConstants.h
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ADVERTISEMENT_FREE_PAGES 5
#define PAGE_READ_IN_SECONDS 1
#define URL_BASE_ADDRESS @"http://cryptic-cove-8532.herokuapp.com"
#define URL_AMAZON @"https://s3.amazonaws.com/com.turtletail.java-bucket"


@interface TTConstants : NSObject

+(NSString*)temporaryFilePath;

@end
