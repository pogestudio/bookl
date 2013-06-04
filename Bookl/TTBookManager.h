//
//  TTBookManager.h
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
@class TTBook;

@interface TTBookManager : NSObject
{
    @private
    UINavigationController *_navConToPresentReaderIn;
}

+(TTBookManager*)sharedManager;

-(void)startReadingBook:(id)book withProgressDelegate:(id)delegate;
-(void)navConToPresentReaderIn:(UINavigationController*)navCon;

@end
