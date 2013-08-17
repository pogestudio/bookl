//
//  Book+copyFromServerBook.m
//  TurtleTail
//
//  Created by CA on 6/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "Book+copyFromServerBook.h"
#import "TTBook.h"
#import "TTCoreDataFactory.h"
#import "Author.h"

@implementation Book (copyFromServerBook)

-(void)fillUpWithDataFromServerBook:(TTBook *)serverBook
{
    Author *author = [[TTCoreDataFactory sharedFactory] newAuthor];
    author.firstName = serverBook.author;
    [self addAuthorsObject:author];
    
    self.title = serverBook.title;
    self.publishingYear = [NSNumber numberWithInt:[serverBook.publishingYear intValue]];
    self.pdfUrl = serverBook.pdfUrl;
    self.bookId = serverBook.bookId;
    //self.publisher = serverBook.publisher;
}

@end
