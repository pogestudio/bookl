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
    
    BOOL hasWifi = [Reachability isConnectedToWifi];
    BOOL hasInternet = [Reachability isConnectedToInternet];
    
    if ([book isKindOfClass:[TTBook class]]) {
        
        TTBook *bookToRead = (TTBook*)book;
        if ([bookToRead isDownloaded]) {
            
            if (hasInternet) {
            [[TTBookOpener sharedOpener] openBook:bookToRead inNavCon:_navConToPresentReaderIn];
            } else {
                [self popInternetReadAlert];
            }
            
        } else {
            
            if (hasWifi) {
                [bookToRead download];
            } else {
                [self popWifiForDownloadAlert];
            }

        }
        
    } else if([book isKindOfClass:[Book class]])
    {
        
        Book *bookToRead = (Book*)book;
        if ([bookToRead isDownloaded]) {
            
            if (hasInternet) {
                [[TTBookOpener sharedOpener] openBook:bookToRead inNavCon:_navConToPresentReaderIn];
            } else {
                [self popInternetReadAlert];
            }
        }
        
        else if(hasWifi){
            [bookToRead downloadWithProgressBarDelegate:delegate];
        } else {
            [self popWifiForDownloadAlert];
        }
        
    } else {
        NSAssert(nil, @"should never be here, passed wrong object to startReadingBook");
    }
}

-(void)setNavConToPresentReaderIn:(UINavigationController *)navCon
{
    _navConToPresentReaderIn = navCon;
}

#pragma mark Connectivity Queries
-(void)popWifiForDownloadAlert
{
        // open an alert with just an OK button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WiFi Needed" message:@"You need to connect to a WiFi to download books"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
}

-(void)popInternetReadAlert
{
        // open an alert with just an OK button
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Needed" message:@"You need an internet connection to read books"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
}

@end