//
//  TTPageManager.m
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.


#import "TTPageManager.h"
#import "TTAdHandler.h"
#import "BKHTTPClient.h"
#import "BKIAPManager.h"
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
        [self sendPageNumberToServer:page];
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
    if (_pagesRead >= ADVERTISEMENT_FREE_PAGES) {
        shouldShowAds = YES;
        _pagesRead = 0;
    }
    
    BOOL adRemovalIsPurchased = [[BKIAPManager sharedInstance] adRemovalIsValid];
    if (adRemovalIsPurchased) {
        shouldShowAds = NO;
    }
    return shouldShowAds;
}

#pragma mark AdControl delegate
-(void)adIsDone
{
    [self startReadingPage:_pageBeneathAdvertisement];
}
         
#pragma mark Server connections
-(void)sendPageNumberToServer:(NSUInteger)pageNumber
{
    NSString *bookId = self.bookId;
    NSString *urlForPull = [NSString stringWithFormat:@"%@/api/edition/read?editionid=%@&page=%d",URL_BASE_ADDRESS,bookId,pageNumber];
    
    NSURL *url = [NSURL URLWithString:urlForPull];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    BKHTTPClient *client = [[BKHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Received success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Got error with: %@",[error localizedDescription]);
    }];
    [operation start];
}



@end