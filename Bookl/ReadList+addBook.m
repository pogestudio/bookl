//
//  ReadList+addBook.m
//  TurtleTail
//
//  Created by CA on 6/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "ReadList+addBook.h"
#import "Book.h"

@implementation ReadList (addBook)

- (void)addBookToList:(Book *)THEBOOK {
    
    for (Book *aBook in self.books) {
        if ([aBook.bookId isEqualToString:THEBOOK.bookId]) {
            return; //bail out if the book already exists in the read list
        }
    }
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.books];
    [tempSet addObject:THEBOOK];
    self.books = tempSet;
}

@end
