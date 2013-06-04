//
//  TTPageManager.h
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTAdHandler.h"

@interface TTPageManager : NSObject <AdControlDelegate>
{
    @private
    NSUInteger _pagesRead;
    NSUInteger _pageBeneathAdvertisement;
}

@property (strong, nonatomic) NSMutableDictionary *savedPages;
@property (strong) TTAdHandler *adHandler;


+(TTPageManager*)sharedManager;

-(void)pageWasShown:(NSUInteger)page;
-(void)pageWasHidden:(NSUInteger)page;

@end
