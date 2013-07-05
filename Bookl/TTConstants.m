//
//  TTConstants.m
//  TurtleTail
//
//  Created by CA on 4/26/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "TTConstants.h"

@implementation TTConstants

+(NSString*)temporaryFilePath
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) lastObject];
    NSString *storePath = @"/temporaryBrowsing";
    NSString *fullPath = [path stringByAppendingString:storePath];
    
    //check if direcotry exists, if not create it
    if (![[NSFileManager defaultManager] fileExistsAtPath:fullPath])
    {
        NSError *error;
        
        [[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        if (error) {
            NSLog(@"%@",error);
        }
    }
    return fullPath;
}



@end
