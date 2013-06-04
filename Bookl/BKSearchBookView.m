//
//  BKSearchBook.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKSearchBookView.h"

@interface BKSearchBookView ()

@end

@implementation BKSearchBookView

+(id)fromStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    id vc = [storyboard instantiateViewControllerWithIdentifier:@"SearchBookView"];
    return vc;
}

@end
