//
//  TTReadList.m
//  TurtleTail
//
//  Created by CA on 4/24/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTReadList.h"
#import "TTBook.h"
#import "AFNetworking.h"

@interface TTReadList()

@property (assign) NSUInteger endIndex;


@end


@implementation TTReadList

#pragma mark Instance stuff
- (id)init
{
    self = [super init];
    if (self) {
        self.books = [[NSMutableArray alloc] init];
    }
    return self;
}

//-(void)addBooksObject:(TTBook *)object
//{
//    NSAssert([object isKindOfClass:[TTBook class]], @"trying to add a non-book to readlist");
//    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:self.books];
//    [tempArray addObject:object];
//    self.books = [NSArray arrayWithArray:tempArray];
//}


//
//#pragma mark Temporary Read List Creation Helper Methods alalalal
//+(TTReadList*)listWithTitle:(NSString*)name amountOfBooks:(NSUInteger)bookAmount
//{
//    TTReadList *theList = [[TTReadList alloc] init];
//    theList.title = name;
//    
//    for (NSUInteger bookCount = 0; bookCount < bookAmount; bookCount++) {
//        [theList addBooksObject:[TTBook randomBook]];
//    }
//    return theList;
//}

#pragma mark Server related
-(void)fillReadListWithBooksFromSearch:(NSString *)urlEncodedQuery
{
    NSUInteger interval = 30;
    [self fillReadListWithBooksFromSearch:urlEncodedQuery fromIndex:0 toIndex:interval];
}

-(void)fillReadListWithBooksFromSearch:(NSString *)urlEncodedQuery fromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex
{
    
    NSString *urlForPull = [NSString stringWithFormat:@"%@/api/edition/query?query=%@&start=%d&end=%d",URL_BASE_ADDRESS,urlEncodedQuery,startIndex,endIndex];
    
    NSURL *url = [NSURL URLWithString:urlForPull];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"Received JSON: %@",JSON);
                                                                                            [self fetchIsDone:JSON fromIndex:startIndex toIndex:endIndex];
                                                                                        }
                                                                                        failure:nil];
    [operation start];
    
}

-(void)fetchIsDone:(id)object fromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex
{
    NSLog(@"%@ kind of class",[object class]);
    NSAssert([object isKindOfClass:[NSArray class]], @"result from server is wrong object");
    NSArray *result = (NSArray*)object;
    [self fillWithBooksFromServerResult:result];
    [self.delegate readListFinishedDowloading:self fromIndex:startIndex toIndex:endIndex];
}

-(void)fillWithBooksFromServerResult:(NSArray *)serverResult
{
    NSLog(@"%@",serverResult);
    for (NSDictionary *jsonResult in serverResult) {
        TTBook *newBook = [[TTBook alloc] initWithServerResults:jsonResult];
        [self.books addObject:newBook];
    }
}

@end
