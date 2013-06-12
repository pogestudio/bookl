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

@protocol AdControlDelegate

-(void)adIsDone;

@end

@interface TTAdHandler : NSObject <ADInterstitialAdDelegate,MobFoxVideoInterstitialViewControllerDelegate>

-(id)initWithAdDelegate:(id<AdControlDelegate>)delegate;
-(void)presentAd;

@end
