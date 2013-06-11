//
//  TTAdHandler.m
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTAdHandler.h"
#import "TTFullPageAdVC.h"


@interface TTAdHandler()

@property (weak) id<AdControlDelegate> pageManager;
@property (strong) ADInterstitialAd *fullScreenIAd;

@end

@implementation TTAdHandler

-(id)initWithAdDelegate:(id<AdControlDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.pageManager = delegate;
        [self reloadAds];
    }
    return self;
}

-(void)presentAd
{
    UINavigationController *mainNavCon = [kAppDelegate mainNavCon];
    UIViewController *presentingVC = [mainNavCon.viewControllers lastObject];
    [self.fullScreenIAd presentFromViewController:presentingVC];
}

-(BOOL)isAdLoaded
{
    BOOL IAdLoaded = self.fullScreenIAd.loaded;
    return IAdLoaded;
}

-(void)returnToBook
{
    [self reloadAds];
}

#pragma mark Interstitial Delegate
-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    [self returnToBook];
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    [self returnToBook];
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"ad failed with error: %@",error);
    [self reloadIad];
}

#pragma mark Ad Fillup Logic

-(void)reloadAds
{
    [self reloadIad];
}

-(void)reloadIad
{
    self.fullScreenIAd  = [[ADInterstitialAd alloc] init];
    self.fullScreenIAd.delegate = self;
}

@end
