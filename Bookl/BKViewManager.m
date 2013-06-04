//
//  BKViewManager.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKViewManager.h"
#import "BKHomeView.h"
#import "BKReadlistView.h"
#import "BKSearchBookView.h"
#import "BKLeftMenu.h"

@interface BKViewManager ()

@end

static BKViewManager *_sharedViewManager;

@implementation BKViewManager

+(BKViewManager*)sharedViewManager
{
    if (!_sharedViewManager) {
        _sharedViewManager = [[BKViewManager alloc] init];
    }
    return _sharedViewManager;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[BKLeftMenu class]]) {
        BKLeftMenu *leftMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenu"];
        leftMenu.viewManager = self;
        self.slidingViewController.underLeftViewController = leftMenu;
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];

    [self.slidingViewController setAnchorRightRevealAmount:MENU_WIDTH];
}

#pragma mark -
#pragma mark Look Related
-(void)setUpView
{
    [self setUpMainContainerView];
    [self setUpInitialView];
}

-(void)setUpMainContainerView
{
    CGFloat yPos = 0;
    CGFloat xPos = 0;
    CGRect mainContainerFrame = CGRectMake(xPos, yPos,
                                           self.view.frame.size.width,
                                           self.view.frame.size.height);
    _mainContainerView = [[UIView alloc] initWithFrame:mainContainerFrame];
    _mainContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mainContainerView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:_mainContainerView];
}
-(void)setUpInitialView
{
    
    BKHomeView *home = [BKHomeView fromStoryboard];
    home.viewManager = self;
    [self addChildViewController:home];
    [_mainContainerView addSubview:home.view];
    _currentVCType = TypeOfCurrentVCHome;
    _currentVC = home;
}

#pragma mark -
#pragma mark View Navigation
- (void)transitionToViewController:(UIViewController *)toViewController
{
    UIViewController *currentVC = _currentVC;
    
    [_currentVC willMoveToParentViewController:nil];                        // 1
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:currentVC toViewController:toViewController duration:0 options:UIViewAnimationOptionCurveLinear animations:nil completion:nil];
    [currentVC removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
    _currentVC = toViewController;
}


-(void)presentNewVCOfType:(TypeOfCurrentVC)typeOfVC
{
    [self presentNewVCOfType:typeOfVC withOptions:nil];
}

-(void)presentNewVCOfType:(TypeOfCurrentVC)typeOfVC withOptions:(NSDictionary *)options
{
    BKMainContentTVC *newVC;
    switch (typeOfVC) {
        case TypeOfCurrentVCHome:
        {
            newVC = [BKHomeView fromStoryboard];
        }
            break;
        case TypeOfCurrentVCReadList:
        {
            newVC = [BKReadlistView fromStoryboard];
        }
            break;
        case TypeOfCurrentVCSearchResult:
        {
            newVC = [BKSearchBookView fromStoryboard];
        }
            break;
        default:
            NSAssert(nil,@"got one too may new VCs in containerview. Forgot to set it up?");
            break;
    }
    NSAssert([newVC isKindOfClass:[BKMainContentTVC class]],@"wrong class from NewVC");
    newVC.viewManager = self;
    newVC.view.frame = _mainContainerView.bounds;
    [newVC setUpViewWithOptions:options];
    [self transitionToViewController:newVC];
}

@end
