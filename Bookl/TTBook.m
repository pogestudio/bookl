 //
//  TTBook.m
//  TurtleTail
//
//  Created by CA on 4/24/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTBook.h"
#import "TTBookManager.h"
#import "BKHTTPClient.h"


@implementation TTBook

-(id)initWithServerResults:(NSDictionary*)serverResults
{
    self = [super init];
    if (self) {
        self.title = [serverResults objectForKey:@"title"];
        self.author = [[[serverResults objectForKey:@"authors"] objectAtIndex:0] objectForKey:@"name"];
        self.publishingYear = [self yearFromServerResult:serverResults];
        self.bookId = [serverResults objectForKey:@"edition_uuid"];
        self.publisher = [[serverResults objectForKey:@"publisher"] objectForKey:@"name"];
        self.pdfUrl = [serverResults objectForKey:@"pdf_url"];
        self.pdfUrlUpdated = [NSDate date];
    }
       return self;
}

#pragma mark Server Result interpret helpers
-(NSString*)yearFromServerResult:(NSDictionary*)serverResult
{
    //just take the first component when split by dashes
    NSString *date = [serverResult objectForKey:@"published"];
    NSArray  *components = [date componentsSeparatedByString:@"-"];
    NSString *year = [components count] > 0 ? [components objectAtIndex:0] : @"Unknown";
    return year;
    
}
//
//-(NSString*)pdfUrlFromServerResult:(NSDictionary*)serverResults
//{
//    //get the correct file URL according to current saving standards
//    NSString *fullPDFUrl = [serverResults objectForKey:@"pdfurl"];
//    NSArray *partsOfUrl = [fullPDFUrl componentsSeparatedByString:@"/"];
//    NSArray *flippedParts = [[partsOfUrl reverseObjectEnumerator] allObjects];
//    NSString *bucket = flippedParts[1];
//    NSString *fileName = flippedParts[0];
//    NSString *rightURL = [NSString stringWithFormat:@"%@/%@",bucket,fileName];
//    return rightURL;
//
//}

#pragma mark Other
-(BOOL)isDownloaded
{
    //CHECK IF EXISTS IN TEMP CACHE
    BOOL doesBookExist = [[NSFileManager defaultManager] fileExistsAtPath:[self filePath]];
    return doesBookExist;
}

-(void)download
{
    [Flurry logEvent:@"Downloading book"];
    BKHTTPClient *client = [BKHTTPClient clientWithBaseURL:[NSURL URLWithString:URL_AMAZON]];
    
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
