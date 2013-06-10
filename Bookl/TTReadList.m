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
    NSLog(@"Starting downloading books!");
//    [[TTServerInterface sharedInterface] getSearchForQuery:urlEncodedQuery ToObject:self];
    NSString *urlForPull = [NSString stringWithFormat:@"%@/api/search?query=%@",URL_BASE_ADDRESS,urlEncodedQuery];
    NSURL *url = [NSURL URLWithString:urlForPull];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSLog(@"%@",urlForPull);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                            NSLog(@"Received JSON: %@",JSON);
                                                                                            [self fetchIsDone:JSON];
                                                                                        }
                                                                                        failure:nil];
    [operation start];
    
}

-(void)fetchIsDone:(id)object
{
    NSAssert([object isKindOfClass:[NSDictionary class]], @"result from server is wrong object");
    NSDictionary *result = (NSDictionary*)object;
    [self fillWithBooksFromServerResult:result];
    [self.delegate readListFinishedDowloading:self];
}

-(void)fillWithBooksFromServerResult:(NSDictionary *)serverResult
{
    NSArray *unParsedBooks = [serverResult objectForKey:@"Result"];
    for (NSDictionary *jsonResult in unParsedBooks) {
        TTBook *newBook = [[TTBook alloc] initWithServerResults:jsonResult];
        [self.books addObject:newBook];
    }
}

@end
