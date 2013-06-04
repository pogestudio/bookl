//
//  TTBookOpener.h
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTBook;

@interface TTBookOpener : NSObject

-(void)openBook:(id)bookToOpen inNavCon:(UINavigationController*)navCon;
+(TTBookOpener*)sharedOpener;

@end
