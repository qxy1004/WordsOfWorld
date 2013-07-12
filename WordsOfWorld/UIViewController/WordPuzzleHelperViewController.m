//
//  WordPuzzleHelperViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordPuzzleHelperViewController.h"
#import "WWConstant.h"
#import "BQDefine.h"
#import "WordPuzzleSecondViewController.h"
#import "UITabBarController+ShowHideBar.h"

#define gap 10
#define buttonWidth ((320-gap*5)/4)

@interface WordPuzzleHelperViewController ()

@end

@implementation WordPuzzleHelperViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = TITLE_PUZZLE;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController setHidden:NO];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Initialise scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenToolBarHeight-kScreenNavigationBarHeight)];
    [scrollView setContentSize:CGSizeMake(kScreenWidth, 8*gap+7*buttonWidth)];
    [self.view addSubview:scrollView];
    
    //Initialise buttons
    for (int i = 1; i <= 4; i++) {
        for (int j = 1; j <= 7; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(i*gap + (i-1)*buttonWidth, j*gap + (j-1)*buttonWidth, buttonWidth, buttonWidth);
            [button setTitle:[NSString stringWithFormat:@"%d", i+(j-1)*4] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i+(j-1)*4;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];
        }
    }
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
#ifdef DEBUG
	NSLog(@"dealloc %@", self);
#endif
}


#pragma mark - Self functions
- (void)buttonClick:(UIButton *)sender{
    UIButton *button = sender;
    
    WordPuzzleSecondViewController *secondViewController = [[WordPuzzleSecondViewController alloc] initWithNibName:nil bundle:nil];
    secondViewController.sizeOfWord = button.tag;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:secondViewController animated:YES];
}
@end
