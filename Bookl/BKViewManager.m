//
//  BKViewManager.m
//  Bookl
//
//  Created by CA on 6/4/13.
//  Copyright (c) 2013 PogeStudio. All rights reserved.
//

#import "BKViewManager.h"
#import "BKHomeView.h"
#import "BKAllReadlistsViewer.h"
#import "BKSearchBookView.h"
#import "BKLeftMenu.h"
#import "BKUserManager.h"

@interface BKViewManager ()

@property (strong, nonatomic) BKSearchBookView *theSearchVC;

@end

static BKViewManager *_sharedViewManager;
static BOOL _viewHasBeenShowedOnce;

@implementation BKViewManager

@synthesize theSearchVC = _theSearchVC;

+(BKViewManager*)sharedViewManager
{
    return _sharedViewManager;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpView];
    
    _sharedViewManager = self;
    
    self.view.backgroundColor = [BKColors currentColors].mainCellBackground;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UINavigationController *leftMenuNavCon = (UINavigationController*)self.slidingViewController.underLeftViewController;
    if (![[leftMenuNavCon.viewControllers lastObject] isKindOfClass:[BKLeftMenu class]]) {
        //it's a navcon because we want the bottom toolbar
        UINavigationController *leftmenuNavcon = [self.storyboard instantiateViewControllerWithIdentifier:@"NewNavCon"];
        BKLeftMenu *leftMenu = [leftmenuNavcon.viewControllers lastObject];
        leftMenu.viewManager = self;
        self.slidingViewController.underLeftViewController = leftmenuNavcon;
        
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    [self.slidingViewController setAnchorRightRevealAmount:LEFT_MENU_WIDTH];
    
    if (!_viewHasBeenShowedOnce) {
        [self.slidingViewController anchorTopViewTo:ECRight];
        _viewHasBeenShowedOnce = YES;
    }
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
    _mainContainerView.backgroundColor = [[BKColors currentColors] mainCellBackground];
    
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
    
    toViewController.view.alpha = 0;
    [self transitionFromViewController:currentVC toViewController:toViewController duration:0.1 options:UIViewAnimationOptionCurveLinear animations:^(void){
        
        toViewController.view.alpha = 1;
        currentVC.view.alpha = 0.3;
    }
                            completion:nil];
    [toViewController didMoveToParentViewController:self];
    _currentVC = toViewController;
    [currentVC removeFromParentViewController];
}


-(void)presentNewVCOfType:(TypeOfCurrentVC)typeOfVC
{
    [[BKUserManager sharedInstance] makeSureUserIsLoggedIn];
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
            newVC = [BKAllReadlistsViewer fromStoryboard];
        }
            break;
        case TypeOfCurrentVCSearchResult:
        {
            newVC = self.theSearchVC;
        }
            break;
        default:
            NSAssert(nil,@"got one too may new VCs in containerview. Forgot to set it up?");
            break;
    }
    NSAssert([newVC isKindOfClass:[BKMainContentTVC class]],@"wrong class from NewVC");
    newVC.viewManager = self;
    newVC.view.frame = _mainContainerView.bounds;
    [self transitionToViewController:newVC];
}

#pragma mark Menus
-(void)showRightMenu:(UIViewController *)rightMenu
{
    [self.slidingViewController setAnchorLeftRevealAmount:rightMenu.view.frame.size.width];
    self.slidingViewController.underRightViewController = rightMenu;
    [self.slidingViewController anchorTopViewTo:ECLeft];
}

-(void)reloadMiddleTable
{
    NSAssert([_currentVC isKindOfClass:[UITableViewController class]], @"trying to reload a VC which isn't TVC");
    UITableViewController *topViewController = (UITableViewController*)_currentVC;
    [topViewController.tableView reloadData];
}

-(UIViewController*)middleTable
{
    return _currentVC;
}

#pragma mark Search View
-(BKSearchBookView*)theSearchVC
{
    if (!_theSearchVC) {
        _theSearchVC = [BKSearchBookView fromStoryboard];
    }
    return _theSearchVC;
}

@end
