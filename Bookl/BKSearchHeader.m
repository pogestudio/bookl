//
//  BKSearchHeader.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSearchHeader.h"
#import "NSString+de_encoding.h"
#import "NSDate+Compare.h"

#define SEARCH_DELAY 0.5

@interface BKSearchHeader ()

@end

@implementation BKSearchHeader

-(void)viewDidLoad
{
    [super viewDidLoad];
    _watchlist = [[NSMutableDictionary alloc] init];
}

#pragma mark -
#pragma mark Search Bar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText isEqualToString:@""]) {
        return; //bail out, and dont search, if string is empty
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fetchDataAccordingToSearchInput:) object:searchBar];
    
    [self performSelector:@selector(fetchDataAccordingToSearchInput:) withObject:searchBar afterDelay:SEARCH_DELAY];
    
}

#pragma mark -
#pragma mark Fetching more data to table view
-(void)fetchDataAccordingToSearchInput:(id)sender
{
    NSAssert1([sender isKindOfClass:[UISearchBar class]],@"Something other than searchbar was sent with search",nil);
    UISearchBar *searchBar = (UISearchBar*)sender;
    NSString *stringToSearch = searchBar.text;
    [self searchWithTextFromSearchBar:stringToSearch];
}

-(void)searchWithTextFromSearchBar:(NSString*)searchText
{
    NSLog(@"WILL SEARCH FOR TEXT: %@",[searchText urlencode]);
    
    TTReadList *newReadlist = [[TTReadList alloc] init];
    newReadlist.delegate = self;
    [newReadlist fillReadListWithBooksFromSearch:[searchText urlencode]];
    [_watchlist setObject:newReadlist forKey:[NSDate date]];
}

#pragma mark ReadlistDelegate
-(void)readListFinishedDowloading:(TTReadList *)readlist fromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)endIndex
{
    NSDate *timeQueryWasSent = [[_watchlist allKeysForObject:readlist] lastObject];
    if ([timeQueryWasSent isLaterThan:_dateOfLastDeliveredReadlist] || _dateOfLastDeliveredReadlist == nil) {
        [self.readListDelegate readListFinishedDowloading:readlist fromIndex:startIndex toIndex:endIndex];
        _dateOfLastDeliveredReadlist = timeQueryWasSent;
    }
    [_watchlist removeObjectForKey:timeQueryWasSent];
}
@end
