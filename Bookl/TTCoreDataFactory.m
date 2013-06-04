//
//  TTCoreDataFactory.m
//  TurtleTail
//
//  Created by CA on 5/31/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTCoreDataFactory.h"
#import "BKAppDelegate.h"

#import "Book.h"
#import "ReadList.h"
#import "Author.h"
#import "User.h"

#import "TTBook.h"

static TTCoreDataFactory *_sharedFactory;

@implementation TTCoreDataFactory

+(TTCoreDataFactory*)sharedFactory
{
    if (!_sharedFactory) {
        _sharedFactory = [[TTCoreDataFactory alloc] init];
    }
    return _sharedFactory;
}

-(id)CDObjectFromEntityName:(NSString*)entity
{
    id delegate = [UIApplication sharedApplication].delegate;
    NSAssert([delegate isKindOfClass:[BKAppDelegate class]], @"wrong class for app delegate");
    BKAppDelegate *appDel = (BKAppDelegate*)delegate;
    NSManagedObjectContext *context = appDel.managedObjectContext;
    
    
    NSManagedObject *newObject = [NSEntityDescription
                                    insertNewObjectForEntityForName:entity
                                    inManagedObjectContext:context];
    NSAssert(newObject != nil, @"CD obj is nil directly after creation!");
    return newObject;
}

-(id)newReadlist
{
    ReadList *newReadList = [self CDObjectFromEntityName:@"ReadList"];
    NSAssert([newReadList isKindOfClass:[ReadList class]], @"wrong class from CD Factory");
    return newReadList;
}

-(id)newBook
{
    Book *newBook = [self CDObjectFromEntityName:@"Book"];
    NSAssert([newBook isKindOfClass:[Book class]], @"wrong class from CD Factory");
    return newBook;
}

-(id)newAuthor
{
    Author *newAuthor = [self CDObjectFromEntityName:@"Author"];
    NSAssert([newAuthor isKindOfClass:[Author class]], @"wrong class from CD Factory");
    return newAuthor;
}


//#pragma mark CD
//-(void)saveContext
//{
//    BKAppDelegate *appDel = [UIApplication sharedApplication].delegate;
//    [appDel saveContext];
//}

@end
