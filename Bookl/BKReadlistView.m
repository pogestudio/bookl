//
//  BKReadlistView.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKReadlistView.h"

@interface BKReadlistView ()

@end

@implementation BKReadlistView

+(id)fromStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    id homeVC = [storyboard instantiateViewControllerWithIdentifier:@"ReadlistView"];
    return homeVC;
}


#pragma mark Standard
-(void)viewDidLoad
{
    [super viewDidLoad];
    UINib *sharedCell = [UINib nibWithNibName:@"TTSharedBookCell" bundle:nil];
    [self.tableView registerNib:sharedCell forCellReuseIdentifier:@"SharedBookCell"];
}

-(void)setUpViewWithOptions:(NSDictionary *)options
{
//    NSString *searchQuery = [options objectForKey:@"query"];
//    NSLog(@"want to init search with:%@",searchQuery);
//    self.theReadList = [[TTReadList alloc] init];
//    self.theReadList.delegate = self;
//    [self.theReadList fillReadListWithBooksFromSearch:searchQuery];
    
}

@end
