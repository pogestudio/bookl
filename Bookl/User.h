//
//  User.h
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ReadList;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * currentToken;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *readLists;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addReadListsObject:(ReadList *)value;
- (void)removeReadListsObject:(ReadList *)value;
- (void)addReadLists:(NSSet *)values;
- (void)removeReadLists:(NSSet *)values;

@end
