//
//  TTBookOpener.m
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTBookOpener.h"
#import "TTBook.h"
#import "ReaderViewController.h"
#import "Book.h"

@implementation TTBookOpener

static TTBookOpener *_sharedOpener;


+(TTBookOpener*)sharedOpener
{
    if (!_sharedOpener) {
        _sharedOpener = [[TTBookOpener alloc] init];
    }
    return _sharedOpener;
}

-(void)openBook:(id)bookToOpen inNavCon:(UINavigationController *)navCon
{
    
	NSString *password = nil; // Document password (for unlocking most encrypted PDF files)
    
    NSString *bookId;
    
    if ([bookToOpen isKindOfClass:[TTBook class]]) {
        bookId = ((TTBook*)bookToOpen).bookId;
    } else if([bookToOpen isKindOfClass:[Book class]]){
        bookId = ((Book*)bookToOpen).bookId;
    }
    else {
        NSAssert(nil, @"should never be here, passed wrong object to startReadingBook");
    }

    NSString *bookFileName = [NSString stringWithFormat:@"%@.pdf",bookId];
    NSString *resourcePath = [TTConstants temporaryFilePath];
    NSString *completePath = [NSString stringWithFormat:@"%@/%@",resourcePath,bookFileName];
    
    
	ReaderDocument *document = [ReaderDocument withDocumentFilePath:completePath password:password];
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document book:bookToOpen];
        
		[navCon pushViewController:readerViewController animated:YES];
	}
}


@end
