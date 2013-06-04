//
//  ReadList+addServerBook.h
//  TurtleTail
//
//  Created by CA on 6/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "ReadList+addBook.h"
@class TTBook;

@interface ReadList (addServerBook)

-(void)addServerBooksObject:(TTBook*)bookObject;

@end
