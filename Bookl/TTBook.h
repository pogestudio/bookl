//
//  TTBook.h
//  TurtleTail
//
//  Created by CA on 4/24/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProgressBarDelegate <NSObject>

-(void)setProgressBarPercentage:(CGFloat)percentage;

@end

@interface TTBook : NSObject

@property (strong) NSString *title;
@property (strong) NSString *author;
@property (strong) NSString *publishingYear;
@property (strong) NSString *bookId;
@property (strong) NSString *pdfUrl;
@property (strong) NSString *publisher;
@property (strong) NSString *publicRating;

@property (assign) CGFloat amountDownloaded; //used only during download phase. 


@property (weak) id<ProgressBarDelegate> progressDelegate;

-(id)initWithServerResults:(NSDictionary*)serverResults;

-(BOOL)isDownloaded;
-(void)download;

@end
