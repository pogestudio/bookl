//
//  TTAdHandler.h
//  TurtleTail
//
//  Created by CA on 5/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import <MobFox/MobFox.h>
#import <RevMobAds/RevMobAds.h>
#import "FlurryAdDelegate.h"

@protocol AdControlDelegate

-(void)adIsDone;

@end

@interface TTAdHandler : NSObject <ADInterstitialAdDelegate,FlurryAdDelegate,RevMobAdsDelegate>

-(id)initWithAdDelegate:(id<AdControlDelegate>)delegate;
-(void)presentAd;


@property (nonatomic, strong)RevMobFullscreen *revMobFullscreen;


@end
