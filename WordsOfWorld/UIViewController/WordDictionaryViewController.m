//
//  WordDictionaryViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordDictionaryViewController.h"
#import "WWConstant.h"
#import "WWCoreFunction.h"
#import "BQDefine.h"
#import "WordDefinitionViewController.h"
#import "UITabBarController+ShowHideBar.h"

@interface WordDictionaryViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>{
    UITableView *mainTable;
    NSArray *arrayOfWords;
    NSMutableArray *arrayOfSearch;
    
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}

@end

@implementation WordDictionaryViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = TITLE_DICTIONARY;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController setHidden:NO];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
	// Do any additional setup after loading the view.
    arrayOfWords = [WWCoreFunction loadWords:@"words"];
    arrayOfSearch = [[NSMutableArray alloc] init];
    
    //Set up table
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kContentHeight) style:UITableViewStylePlain];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.backgroundColor = [UIColor clearColor];
    mainTable.backgroundView = nil;
    [self.view addSubview:mainTable];
    
    // setup searchBar and searchDisplayController
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.placeholder = @"Please enter here";
    //searchBar.prompt = [NSString stringWithFormat:@"Words in total %d", [arrayOfWords count]];
    //searchBar.tintColor = [UIColor clearColor];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    //mainTable.tableHeaderView = searchBar;
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    searchDisplayController.delegate = self;
    
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

#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    if (tableView == searchDisplayController.searchResultsTableView) {
        return [arrayOfSearch count];
    } else {
        return [arrayOfWords count];
    }
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
    
    if (tableView == searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [arrayOfSearch objectAtIndex:indexPath.row];
        //searchBar.prompt = [NSString stringWithFormat:@"Words in total %d", [arrayOfSearch count]];
    } else {
        cell.textLabel.text = [arrayOfWords objectAtIndex:indexPath.row];
        //searchBar.prompt = [NSString stringWithFormat:@"Words in total %d", [arrayOfWords count]];
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WordDefinitionViewController *definitionViewController = [[WordDefinitionViewController alloc] initWithNibName:nil bundle:nil];
    if (tableView == searchDisplayController.searchResultsTableView) {
        definitionViewController.string = [arrayOfSearch objectAtIndex:indexPath.row];
    } else {
        definitionViewController.string = [arrayOfWords objectAtIndex:indexPath.row];
    }

    [self.navigationController pushViewController:definitionViewController animated:YES];
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [arrayOfSearch removeAllObjects];
    
    for(NSString *string in arrayOfWords){
        
        NSRange range = [string rangeOfString:searchString options:NSCaseInsensitiveSearch];
        if (range.length != 0) {
            [arrayOfSearch addObject:string];
        }
    }
    return YES;
}

@end
