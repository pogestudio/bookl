 //
//  TTBook.m
//  TurtleTail
//
//  Created by CA on 4/24/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTBook.h"
#import "TTBookManager.h"
#import "AFNetworking.h"

@implementation TTBook

-(id)initWithServerResults:(NSDictionary*)serverResults
{
    self = [super init];
    if (self) {
        self.title = [serverResults objectForKey:@"title"];
        self.author = [[serverResults objectForKey:@"authors"] objectAtIndex:0];
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

-(void)download
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:URL_AMAZON]];
    
    void (^success)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"WE HAS SUCCESS :D");
    };
    
    void (^failure)(AFHTTPRequestOperation*, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"WE HAS failure :((. OPERATION:\n\n%@ \n\nResponseObject:\n\n%@",operation,responseObject);
    };
    
    NSURLRequest *request = [client requestWithMethod:@"GET" path:self.pdfUrl parameters:nil];
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:success failure:failure];
    

    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:[self filePath] append:NO];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        CGFloat percentage = (float) totalBytesRead / totalBytesExpectedToRead;
        [self.progressDelegate setProgressBarPercentage:percentage];
    }];
    [client enqueueHTTPRequestOperation:operation];
}

-(NSString*)filePath
{
    return [NSString stringWithFormat:@"%@/%@.pdf",[TTConstants temporaryFilePath],self.bookId];
}

@end
