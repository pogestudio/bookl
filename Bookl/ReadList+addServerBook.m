//
//  ReadList+addServerBook.m
//  TurtleTail
//
//  Created by CA on 6/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "ReadList+addServerBook.h"
#import "TTCoreDataFactory.h"
#import "Book+copyFromServerBook.h"

@implementation ReadList (addServerBook)

-(void)addServerBooksObject:(TTBook *)bookObject
{
    Book *newBook = [[TTCoreDataFactory sharedFactory] newBook];
    [newBook fillUpWithDataFromServerBook:bookObject];
    [self addBookToList:newBook];
}

@end
