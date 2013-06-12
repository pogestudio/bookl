//
//  TTAdHandler.m
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTAdHandler.h"
#import "TTFullPageAdVC.h"

#import "FlurryAds.h"



@interface TTAdHandler()
{
    MobFoxAdType _lastLoadedMobfoxType;
}

@property (weak) id<AdControlDelegate> pageManager;
@property (strong) ADInterstitialAd *fullScreenIAd;
@property (nonatomic, strong) MobFoxVideoInterstitialViewController *mobFoxAdVC;
@property (assign) BOOL mobFoxAdLoaded;


@end

#define kFlurryInterstitialAdSpaceName @"INTERSTITIAL_BOOK"

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

#pragma mark presentation
-(void)presentAd
{
    if (self.mobFoxAdLoaded) {
        [self presentMobFox];
    } else if (self.fullScreenIAd.loaded)
    {
        [self presentIAd];
    } else if ([self flurryAdIsReady]) {
        [self presentFlurryAd];
    } else {
        NSLog(@"NO AD IS LOADED WTF");
    }
}

-(void)returnToBook
{
    [self.pageManager adIsDone];
}

#pragma mark Ad Fillup Logic

-(void)reloadAds
{
    [self reloadIAd];
    [self reloadMobfox];
    [self reloadFlurryAd];
}

#pragma mark iAd reload and Delegate
-(void)reloadIAd
{
    self.fullScreenIAd  = [[ADInterstitialAd alloc] init];
    self.fullScreenIAd.delegate = self;
}

-(void)presentIAd
{
    UINavigationController *mainNavCon = [kAppDelegate mainNavCon];
    UIViewController *presentingVC = [mainNavCon.viewControllers lastObject];
    [self.fullScreenIAd presentFromViewController:presentingVC];
    
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    [self reloadIAd];
    [self returnToBook];
}

-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    [self reloadIAd];
    [self returnToBook];
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    NSLog(@"iAd failed with error: %@",[error localizedDescription]);
    [self reloadIAd];
}

#pragma mark MobFox reload and delegate
-(void)reloadMobfox
{
    self.mobFoxAdVC = [[MobFoxVideoInterstitialViewController alloc] init];
    self.mobFoxAdVC.delegate = self;
    self.mobFoxAdVC.locationAwareAdverts = YES;
    
    self.mobFoxAdVC.requestURL = @"http://my.mobfox.com/vrequest.php";
    [self.mobFoxAdVC requestAd];
    self.mobFoxAdLoaded = NO;
}

-(void)presentMobFox
{
    UINavigationController *mainNavCon = [kAppDelegate mainNavCon];
    UIViewController *presentingVC = [mainNavCon.viewControllers lastObject];
    [presentingVC.view addSubview:self.mobFoxAdVC.view];
    [self.mobFoxAdVC presentAd:_lastLoadedMobfoxType];
    
}

-(NSString*)publisherIdForMobFoxVideoInterstitialView:(MobFoxVideoInterstitialViewController *)videoInterstitial
{
    return @"27e3f27b131a72f44c22b502a8207273";
}

-(void)mobfoxVideoInterstitialViewDidLoadMobFoxAd:(MobFoxVideoInterstitialViewController *)videoInterstitial advertTypeLoaded:(MobFoxAdType)advertType
{
    self.mobFoxAdLoaded = YES;
    _lastLoadedMobfoxType = advertType;
}

-(void)mobfoxVideoInterstitialView:(MobFoxVideoInterstitialViewController *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"failed to receive mobfox: %@",[error localizedDescription]);
    [self reloadMobfox];
}

-(void)mobfoxVideoInterstitialViewDidDismissScreen:(MobFoxVideoInterstitialViewController *)videoInterstitial
{
    [self reloadMobfox];
    [self returnToBook];
}

#pragma mark Flurry reload and delegate
-(void)reloadFlurryAd
{
    UINavigationController *mainNavCon = [kAppDelegate mainNavCon];
    UIViewController *presentingVC = [mainNavCon.viewControllers lastObject];
    
    [FlurryAds fetchAdForSpace:kFlurryInterstitialAdSpaceName
                         frame:presentingVC.view.frame size:FULLSCREEN];
    
    // Register yourself as a delegate for ad callbacks
	[FlurryAds setAdDelegate:self];
}

-(void)presentFlurryAd
{
    UINavigationController *mainNavCon = [kAppDelegate mainNavCon];
    UIViewController *presentingVC = [mainNavCon.viewControllers lastObject];
    
    [FlurryAds displayAdForSpace:kFlurryInterstitialAdSpaceName
                          onView:presentingVC.view];
}

- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    if (interstitial) {
        [self reloadFlurryAd];
        [self returnToBook];
    }
}

-(BOOL)flurryAdIsReady
{
    BOOL isReady = [FlurryAds adReadyForSpace:kFlurryInterstitialAdSpaceName];
    return isReady;
}

- (void) spaceDidFailToReceiveAd:(NSString*)adSpace error:(NSError *)error
{
    NSLog(@"failed to receive mobfox: %@",[error localizedDescription]);
    [self reloadFlurryAd];
}
@end
