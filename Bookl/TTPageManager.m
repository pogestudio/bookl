//
//  TTPageManager.m
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.


#import "TTPageManager.h"
#import "TTAdHandler.h"

static TTPageManager *_sharedManager;

@implementation TTPageManager

+(TTPageManager*)sharedManager
{
    if (!_sharedManager) {
        _sharedManager = [[TTPageManager alloc] init];
    }
    return _sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.savedPages = [[NSMutableDictionary alloc] init];
        _pagesRead = 0;
        self.adHandler = [[TTAdHandler alloc] initWithAdDelegate:self];
    }
    return self;
}


-(void)pageWasShown:(NSUInteger)page
{    
    //if we should show ads, do it here
    BOOL shouldShowAds = [self shouldShowAds];
    if (shouldShowAds) {
        [self.adHandler presentAd];
        _pageBeneathAdvertisement = page;
    } else {
        [self startReadingPage:page];
    }
}

-(void)startReadingPage:(NSUInteger)page
{
    [self.savedPages setObject:[NSDate date] forKey:[NSString stringWithFormat:@"%d",page]];
}

-(void)pageWasHidden:(NSUInteger)page
{
    //get date for sender
    // check if the seconds is above the "XX amount"
    // if it is, report page being read.
    NSDate *firstDate = [self retrieveStartDateForPage:page];
    BOOL pageRead = [self pageWasRead:firstDate];
    if (pageRead) {
        NSLog(@"Page was read!");
        _pagesRead++;
    }
}

//gets the startdate, and removes it from the dictionary
-(NSDate*)retrieveStartDateForPage:(NSUInteger)page
{
    NSDate *date;
    NSString *pageAsString  = [NSString stringWithFormat:@"%d",page];
    for (NSString *key in self.savedPages) {
        if ([key isEqualToString:pageAsString]) {
            date = [self.savedPages objectForKey:key];
            [self.savedPages removeObjectForKey:key]; //remove object
            break;
        }
    }
    return date;
}

-(BOOL)pageWasRead:(NSDate*)startedReading
{
    BOOL pageWasRead = NO;
    NSTimeInterval inBetween = [[NSDate date] timeIntervalSinceDate:startedReading];
    if (inBetween > PAGE_READ_IN_SECONDS) {
        pageWasRead = YES;
    }
    return pageWasRead;
}

#pragma mark Ad Logic
-(BOOL)shouldShowAds
{
    BOOL shouldShowAds = NO;
    BOOL anAdIsLoaded = [self.adHandler isAdLoaded];
    if (_pagesRead >= ADVERTISEMENT_FREE_PAGES && anAdIsLoaded) {
        shouldShowAds = YES;
        _pagesRead = 0;
    }
    return shouldShowAds;
}

-(void)reloadAds
{
    
}

#pragma mark AdControl delegate
-(void)adIsDone
{
    [self startReadingPage:_pageBeneathAdvertisement];
    [self reloadAds];
}


@end