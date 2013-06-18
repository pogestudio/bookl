//
//  NSString+validateEmail.h
//  Bookl
//
//  Created by CA on 6/18/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (validateEmail)

-(BOOL)validateEmailFormatLiberal;
-(BOOL)validateEmailFormatStrict;

@end
