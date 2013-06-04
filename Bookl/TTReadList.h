//
//  TTReadList.h
//  TurtleTail
//
//  Created by CA on 4/24/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TTBook;

@protocol TTReadListObserver <NSObject>

-(void)readListFinishedDowloading;

@end

@interface TTReadList : NSObject

@property (strong) NSMutableArray* books;
@property (strong) NSString* title;
@property (weak) id<TTReadListObserver> delegate;

-(void)fillReadListWithBooksFromSearch:(NSString*)urlEncodedQuery;


@end
