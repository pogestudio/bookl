//
//  Book+copyFromServerBook.h
//  TurtleTail
//
//  Created by CA on 6/3/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "Book.h"
@class TTBook;

@interface Book (copyFromServerBook)

-(void)fillUpWithDataFromServerBook:(TTBook*)serverBook;

@end
