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
#import "MJNIndexView.h"
#import "SVProgressHUD.h"

@interface WordPuzzleAllSecondViewController () <UITableViewDataSource, UITableViewDelegate, LetterFilter, MJNIndexViewDataSource> {
    UITableView *mainTable;
    NSMutableArray *arrayOfWords;
    
    NSString *stringFilterFromModalView;
}

@property (nonatomic, strong) MJNIndexView *indexView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSString *alphaString;

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
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"All Letters";
    
    [self defaultArrayOfWords];
    
    //sectionArray
    self.sectionArray = [NSMutableArray array];
    
    self.alphaString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (int i=0; i< 26; i++) {
        [self.sectionArray addObject:[self itemsInSection:i]];
    }
    
    // initialise MJNIndexView
	self.indexView = [[MJNIndexView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenNavigationBarHeight)];
	self.indexView.dataSource = self;
	self.indexView.fontColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0];
	
    //Set up table
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenNavigationBarHeight)];
    [mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [mainTable registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.backgroundColor = [UIColor clearColor];
    mainTable.backgroundView = nil;
    mainTable.showsVerticalScrollIndicator = NO;
    [mainTable reloadData];
    [mainTable reloadSectionIndexTitles];
    [self.indexView refreshIndexItems];
    [mainTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self.sectionArray count] -1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [mainTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self.view addSubview:mainTable];
    [self.view addSubview:self.indexView];
    //Add Clear button
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Filter"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(letterButton)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:clearButton, nil];
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
- (void)defaultArrayOfWords{
    if (arrayOfWords != nil) {
        [arrayOfWords removeAllObjects];
    }
    arrayOfWords = (NSMutableArray *)[WWCoreFunction loadWords:@"words"];
}
- (void)letterButton{
    WordLetterFilterViewController *letterViewController = [[WordLetterFilterViewController alloc] initWithNibName:nil bundle:nil];
    letterViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:letterViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark building sectionArray for the tableView
- (NSString *)categoryNameAtIndexPath: (NSIndexPath *)path{
    NSArray *currentItems = self.sectionArray[path.section];
    NSString *category = currentItems[path.row];
    return category;
}
- (NSArray *)itemsInSection: (NSInteger)section{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[cd] %@",[self firstLetter:section]];
    return [arrayOfWords filteredArrayUsingPredicate:predicate];
}
- (NSString *)firstLetter: (NSInteger)section{
    return [[self.alphaString substringFromIndex:section] substringToIndex:1];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sectionArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [self.sectionArray[section]count];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self categoryNameAtIndexPath:indexPath]];
    
    return cell;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    headerView.tintColor = [UIColor whiteColor];
    headerView.textLabel.textColor = [UIColor blackColor];
    [[headerView textLabel] setText:[NSString stringWithFormat:@"%@",[self firstLetter:section]]];
    return headerView;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WordDefinitionViewController *definitionViewController = [[WordDefinitionViewController alloc] initWithNibName:nil bundle:nil];
    definitionViewController.string = [self categoryNameAtIndexPath:indexPath];
    [self.navigationController pushViewController:definitionViewController animated:YES];
}

#pragma mark - MJMIndexForTableView datasource methods
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView{
    NSMutableArray *results = [NSMutableArray array];
    
    for (int i = 0; i < [self.alphaString length]; i++) {
        NSString *substr = [self.alphaString substringWithRange:NSMakeRange(i,1)];
        [results addObject:substr];
    }
    
    return results;
}
- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    [mainTable scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:NO];
}

#pragma mark - LetterFilter delegate
- (void)getLetterFilter:(NSString *)string{
    NSLog(@"%@", string);
    
    [self defaultArrayOfWords];
    stringFilterFromModalView = string;
}
@end