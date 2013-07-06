//
//  TTCoreDataFactory.h
//  TurtleTail
//
//  Created by CA on 5/31/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTBook;
@class Book;

@interface TTCoreDataFactory : NSObject

+(TTCoreDataFactory*)sharedFactory;
-(id)newAuthor;
-(id)newReadlist;
-(id)newBook;

@end
