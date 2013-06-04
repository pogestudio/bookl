//
//  Author.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Author : NSManagedObject

@property (nonatomic, retain) NSString * authorId;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSSet *authorOf;
@end

@interface Author (CoreDataGeneratedAccessors)

- (void)addAuthorOfObject:(Book *)value;
- (void)removeAuthorOfObject:(Book *)value;
- (void)addAuthorOf:(NSSet *)values;
- (void)removeAuthorOf:(NSSet *)values;

@end
