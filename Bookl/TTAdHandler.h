//
//  TTAdHandler.h
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdControlDelegate

-(void)adIsDone;

@end

@interface TTAdHandler : NSObject

-(void)showFullScreenAdWithDelegate:(id<AdControlDelegate>)delegate;

+(TTAdHandler*)sharedHandler;



@end
