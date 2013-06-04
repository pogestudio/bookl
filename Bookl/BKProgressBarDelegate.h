//
//  BKProgressBarDelegate.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BKProgressBarDelegate <NSObject>

-(void)setProgressBarPercentage:(CGFloat)percentage;

@end
