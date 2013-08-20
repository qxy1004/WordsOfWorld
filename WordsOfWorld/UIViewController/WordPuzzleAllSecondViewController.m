//
//  WordPuzzleAllSecondViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 13/08/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordPuzzleAllSecondViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "BQDefine.h"
#import "WordDefinitionViewController.h"
#import "WWCoreFunction.h"
#import "WordLetterFilterViewController.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"

@interface WordPuzzleAllSecondViewController () <UITableViewDataSource, UITableViewDelegate, LetterFilter> {
    UITableView *mainTable;
    NSMutableArray *arrayOfWords;
    
    NSString *stringFilterFromModalView;
    UIBarButtonItem *letterButton;
}

@end

@implementation WordPuzzleAllSecondViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [SVProgressHUD dismiss];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
    
    if (stringFilterFromModalView != nil) {
        [self filterWordsByString:stringFilterFromModalView];
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self defaultArrayOfWords];
    
    self.title = [NSString stringWithFormat:@"All Letters (%d)", [arrayOfWords count]];
    
    //Set up table
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenNavigationBarHeight)];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.backgroundColor = [UIColor clearColor];
    mainTable.backgroundView = nil;
    mainTable.showsVerticalScrollIndicator = NO;
    [mainTable reloadData];
    [mainTable reloadSectionIndexTitles];
    
    [self.view addSubview:mainTable];
    
    __weak WordPuzzleAllSecondViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [mainTable addPullToRefreshWithActionHandler:^{
        [weakSelf dropViewDidBeginRefreshing];
    }];
    
    //Add Clear button
    letterButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Filter"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(letterButton)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:letterButton, nil];
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
- (void)setup{
    [mainTable reloadData];
    self.title = [NSString stringWithFormat:@"All Letters (%d)", [arrayOfWords count]];
}
- (void)defaultArrayOfWords{
    if (arrayOfWords != nil) {
        [arrayOfWords removeAllObjects];
    }
    arrayOfWords = (NSMutableArray *)[WWCoreFunction loadWords:@"words"];
}
- (void)dropViewDidBeginRefreshing{
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self defaultArrayOfWords];
        [self setup];
        [mainTable.pullToRefreshView stopAnimating];
    });
}
- (void)letterButton{
    WordLetterFilterViewController *letterViewController = [[WordLetterFilterViewController alloc] initWithNibName:nil bundle:nil];
    letterViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:letterViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navController animated:YES completion:nil];
}
- (void)filterWordsByString:(NSString *)string{
    [SVProgressHUD showWithStatus:@"Processing"];
    self.navigationItem.rightBarButtonItems = nil;
    
    NSMutableArray *results = [NSMutableArray arrayWithArray:arrayOfWords];
    [arrayOfWords removeAllObjects];
    [self setup];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(queue, ^{
        for (NSString *word in results) {
            BOOL isWordOK = YES;
            for (int i = 0; i < [word length]; i++) {
                NSRange range = [string rangeOfString:[NSString stringWithFormat:@"%c", [word characterAtIndex:i]]];
                if (range.length > 0){
                    continue;
                }
                else {
                    isWordOK = NO;
                    break;
                }
            }
            if (isWordOK) {
                [arrayOfWords addObject:word];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    //[mainTable insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:([arrayOfWords count]-1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self setup];
                });
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:letterButton, nil];
        });
    });
}

#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [arrayOfWords count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        [cell.textLabel setTextColor:[UIColor blackColor]];
        [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    cell.textLabel.text = [arrayOfWords objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    stringFilterFromModalView = nil;
    
    WordDefinitionViewController *definitionViewController = [[WordDefinitionViewController alloc] initWithNibName:nil bundle:nil];
    definitionViewController.string = [arrayOfWords objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:definitionViewController animated:YES];
}

#pragma mark - LetterFilter delegate
- (void)getLetterFilter:(NSString *)string{
    NSLog(@"%@", string);
    
    [self defaultArrayOfWords];
    stringFilterFromModalView = string;
}

@end