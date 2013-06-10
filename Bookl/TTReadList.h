//
//  TTReadList.h
//  TurtleTail
//
//  Created by CA on 4/24/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTReadList;
@class TTBook;

@protocol TTReadListDelegate <NSObject>

-(void)readListFinishedDowloading:(TTReadList*)readlist;

@end

@interface TTReadList : NSObject

@property (strong) NSMutableArray* books;
@property (strong) NSString* title;
@property (weak) id<TTReadListDelegate> delegate;

-(void)fillReadListWithBooksFromSearch:(NSString*)urlEncodedQuery;


@end
