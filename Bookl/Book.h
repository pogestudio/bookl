//
//  Book.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Author, ReadList;

@interface Book : NSManagedObject

@property (nonatomic, retain) NSNumber * amountDownloaded;
@property (nonatomic, retain) NSString * bookId;
@property (nonatomic, retain) NSString * pdfUrl;
@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSNumber * publishingYear;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * yourRating;
@property (nonatomic, retain) NSSet *authors;
@property (nonatomic, retain) ReadList *ownerReadList;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addAuthorsObject:(Author *)value;
- (void)removeAuthorsObject:(Author *)value;
- (void)addAuthors:(NSSet *)values;
- (void)removeAuthors:(NSSet *)values;

@end
