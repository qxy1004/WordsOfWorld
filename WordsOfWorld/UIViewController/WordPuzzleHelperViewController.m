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
#import "WordPuzzleAllSecondViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"

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
    self.navigationItem.title = @"Puzzle Helper";
    [self.tabBarController setHidden:NO];
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Initialise scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenToolBarHeight-kScreenNavigationBarHeight)];
    [scrollView setContentSize:CGSizeMake(kScreenWidth, 8*gap+6*buttonWidth)];
    [self.view addSubview:scrollView];
    
    //Initialise buttons
    for (int i = 1; i <= 4; i++) {
        for (int j = 1; j <= 6; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor whiteColor];
            button.frame = CGRectMake(i*gap + (i-1)*buttonWidth, j*gap + (j-1)*buttonWidth, buttonWidth, buttonWidth);
            if (i+(j-1)*4 == 1) {
                [button setTitle:@"All" forState:UIControlStateNormal];
            }
            else{
                [button setTitle:[NSString stringWithFormat:@"%d", i+(j-1)*4] forState:UIControlStateNormal];
            }
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i+(j-1)*4;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.borderColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
            button.layer.borderWidth = 0.5f;
            button.layer.cornerRadius = 10.0f;
            [scrollView addSubview:button];
        }
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationItem.title = TITLE_PUZZLE;
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
    
    if (button.tag == 1) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        int64_t delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            WordPuzzleAllSecondViewController *wordPuzzleAllSecondViewController = [[WordPuzzleAllSecondViewController alloc] initWithNibName:nil bundle:nil];
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wordPuzzleAllSecondViewController animated:YES];
        });
    }
    else{
        WordPuzzleSecondViewController *secondViewController = [[WordPuzzleSecondViewController alloc] initWithNibName:nil bundle:nil];
        secondViewController.sizeOfWord = button.tag;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:secondViewController animated:YES];
    }
}

@end
