//
//  WordStatisticsDetailViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 19/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordStatisticsDetailViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "DALinedTextView.h"

@interface WordStatisticsDetailViewController (){
    DALinedTextView *mainTextView;
}

@end

@implementation WordStatisticsDetailViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.stringOfTitle;
    
    mainTextView = [[DALinedTextView alloc] initWithFrame:self.view.bounds];
    mainTextView.editable = NO;
    mainTextView.allowsEditingTextAttributes = YES;
    mainTextView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    mainTextView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:mainTextView];
    
    mainTextView.text = self.stringOfDetails;
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

@end
