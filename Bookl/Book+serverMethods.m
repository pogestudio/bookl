//
//  Book+serverMethods.m
//  TurtleTail
//
//  Created by CA on 5/30/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "Book+serverMethods.h"
#import "TTBookManager.h"
#import "BKHTTPClient.h"

@implementation Book (serverMethods)

@dynamic progressDelegate;


-(id)initWithServerResults:(NSDictionary*)serverResults
{
    self = [super init];
    if (self) {
        self.title = [serverResults objectForKey:@"title"];
        //self.author = [[serverResults objectForKey:@"authors"] objectAtIndex:0];
        //newBook.publishingYear = serverResults
        self.bookId = [serverResults objectForKey:@"ISBN"];
        self.publisher = [serverResults objectForKey:@"publisher"];
        
        //get the correct file URL according to current saving standards
        NSString *fullPDFUrl = [serverResults objectForKey:@"pdfurl"];
        NSArray *partsOfUrl = [fullPDFUrl componentsSeparatedByString:@"/"];
        NSArray *flippedParts = [[partsOfUrl reverseObjectEnumerator] allObjects];
        NSString *bucket = flippedParts[1];
        NSString *fileName = flippedParts[0];
        self.pdfUrl = [NSString stringWithFormat:@"%@/%@",bucket,fileName];
    }
    return self;
}

-(BOOL)isDownloaded
{
    //CHECK IF EXISTS IN TEMP CACHE
    BOOL doesBookExist = [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
    return doesBookExist;
}

-(void)downloadWithProgressBarDelegate:(id<BKProgressBarDelegate>)delegate
{    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASE_ADDRESS]];
    //[client addAuthHeader];
    
    [Flurry logEvent:@"Started downloading Book"];
    void (^success)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        [Flurry logEvent:@"Finished downloading Book"];
    };
    
    void (^failure)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *statusCode = [NSNumber numberWithInt:operation.response.statusCode];
        [Flurry logEvent:@"Failed download" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:statusCode,@"Status Code", nil]];
    };
    
    NSURLRequest *request = [client requestWithMethod:@"GET" path:self.pdfUrl parameters:nil];
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:[self filePath] append:NO];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat percentage = (float) totalBytesRead / totalBytesExpectedToRead;
        [delegate setProgressBarPercentage:percentage];
    }];
    [client enqueueHTTPRequestOperation:operation];
}

-(NSString*)filePath
{
    return [NSString stringWithFormat:@"%@/%@.pdf",[TTConstants temporaryFilePath],self.bookId];
}

@end
