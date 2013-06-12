//
//  TTBookManager.m
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTBookManager.h"
#import "TTBookOpener.h"

#import "TTBook.h"
#import "Book+serverMethods.h"

#import "Reachability.h"

@implementation TTBookManager

static TTBookManager *_sharedManager;

+(TTBookManager*)sharedManager
{
    if (!_sharedManager) {
        _sharedManager = [[TTBookManager alloc] init];
    }
    return _sharedManager;
}

-(void)startReadingBook:(id)book withProgressDelegate:(id)delegate
{
    //if booktoopen exists downloaded, open it.
    //if not, check if Wifi
    
    BOOL hasWifi = [Reachability falseAndMessageIfNotConnectedToWifi];
    
    if ([book isKindOfClass:[TTBook class]]) {
        TTBook *bookToRead = (TTBook*)book;
        if ([bookToRead isDownloaded]) {
            [[TTBookOpener sharedOpener] openBook:bookToRead inNavCon:_navConToPresentReaderIn];
        } else if(hasWifi){
            [bookToRead download];
        }
    } else if([book isKindOfClass:[Book class]]){
        Book *bookToRead = (Book*)book;
        if ([bookToRead isDownloaded]) {
            [[TTBookOpener sharedOpener] openBook:bookToRead inNavCon:_navConToPresentReaderIn];
        } else if(hasWifi){
            
            [bookToRead downloadWithProgressBarDelegate:delegate];
        }
    } else {
        NSAssert(nil, @"should never be here, passed wrong object to startReadingBook");
    }
}

-(void)setNavConToPresentReaderIn:(UINavigationController *)navCon
{
    _navConToPresentReaderIn = navCon;
}

@end