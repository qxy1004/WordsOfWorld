//
//  WordPuzzleSecondViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 12/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordPuzzleSecondViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "WordDefinitionViewController.h"
#import "BQDefine.h"
#import "WWCoreFunction.h"
#import "RNBlurModalView.h"
#import <QuartzCore/QuartzCore.h>
#import "WordLetterFilterViewController.h"
#import "SVPullToRefresh.h"

#define longPressTime 1
#define sizeOfLetterButton kScreenWidth/7.0
#define stringOfBackButton @"Back"
#define stringOfClearButton @"Clear"

@interface WordPuzzleSecondViewController () <UITableViewDataSource, UITableViewDelegate, LetterFilter>{
    UITableView *mainTable;
    NSMutableArray *arrayOfWords;
    UIView *verticalView;
    
    RNBlurModalView *modal;
    BOOL isLocked;
    
    int indexOfChoosen;
    NSString *stringFilterFromModalView;
}

@end

@implementation WordPuzzleSecondViewController

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
    if (stringFilterFromModalView != nil) {
        [self filterWordsByString:stringFilterFromModalView];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self defaultArrayOfWords];
    self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
    self.view.backgroundColor = [UIColor blackColor];
    
    //Set up table
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenNavigationBarHeight-kScreenToolBarHeight) style:UITableViewStylePlain];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    
    __weak WordPuzzleSecondViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [mainTable addPullToRefreshWithActionHandler:^{
        [weakSelf dropViewDidBeginRefreshing];
    }];
    
    //Add explain label in the bottom
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kContentHeight-kScreenNavigationBarHeight-kScreenToolBarHeight + kScreenToolBarHeight/3.0, kScreenWidth, kScreenToolBarHeight/3.0*2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Swipe and hold on this area";
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:label];
    
    //Add index label in the bottom
    for (int i = 1; i <= self.sizeOfWord; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/self.sizeOfWord*(i-1)-1, kContentHeight-kScreenNavigationBarHeight-kScreenToolBarHeight+1, kScreenWidth/self.sizeOfWord+2, kScreenToolBarHeight/3.0)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%d", i];
        label.textColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        
        [self.view addSubview:label];
    }
    
    //Set flag
    isLocked = NO;
    indexOfChoosen = -1;
    
    //Add Clear button
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Letters"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(letterButton)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:clearButton, nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    stringFilterFromModalView = nil;
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
    arrayOfWords = (NSMutableArray *)[WWCoreFunction loadWords:[NSString stringWithFormat:@"%d", self.sizeOfWord]];
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
- (void)buttonClick:(UIButton *)sender{
    isLocked = NO;
    
    UIButton *button = sender;
    
    if ([button.titleLabel.text isEqualToString:stringOfBackButton]) {
        [modal hideWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut completion:^{
            //Update UITableView
            NSLog(@"Press back button");
            [self setup];
        }];
    }
    else if ([button.titleLabel.text isEqualToString:stringOfClearButton]) {
        [modal hideWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut completion:^{
            //Update UITableView
            NSLog(@"Press clear button");
            [self defaultArrayOfWords];
            [self setup];
        }];
    }
    else{
        [modal hideWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut completion:^{
            //Update UITableView
            arrayOfWords = [self filterCurrentWords:arrayOfWords withCharacer:button.titleLabel.text withIndex:indexOfChoosen];
            [self setup];
        }];
    }
}
- (void)fireLongPress {
    // do what you want to do
    NSLog(@"Long press");
    isLocked = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, sizeOfLetterButton*4)];
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView setContentSize:CGSizeMake(kScreenWidth, sizeOfLetterButton*4)];
    
    //Letter button
    for (int i = 0; i <= 27; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i%7*sizeOfLetterButton, i/7*sizeOfLetterButton, sizeOfLetterButton, sizeOfLetterButton);
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
        button.layer.borderWidth = 0.5f;
        button.layer.cornerRadius = 10.0f;
        if (i == 26) {
            [button setTitle:stringOfBackButton forState:UIControlStateNormal];
        }
        else if (i == 27){
            [button setTitle:stringOfClearButton forState:UIControlStateNormal];
        }
        else{
            [button setTitle:[NSString stringWithFormat:@"%c", i+97] forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
    }
    
    [self.view addSubview:scrollView];
    
    modal = [[RNBlurModalView alloc] initWithView:scrollView];
    [modal hideCloseButton:YES];
    
    [modal show];
    
    /*
     [UIView animateWithDuration:0.25
     delay:0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
     mainTable.frame = CGRectMake(sizeOfLetterButton, 0, mainTable.frame.size.width, mainTable.frame.size.height);
     }
     completion:^(BOOL finished) {
     UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, sizeOfLetterButton, kContentHeight-kScreenNavigationBarHeight)];
     scrollView.backgroundColor = [UIColor whiteColor];
     [scrollView setContentSize:CGSizeMake(sizeOfLetterButton, sizeOfLetterButton*27)];
     
     //Clear button
     UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     button.frame = CGRectMake(0, 0, sizeOfLetterButton, sizeOfLetterButton);
     [button setTitle:@"Clear" forState:UIControlStateNormal];
     [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [scrollView addSubview:button];
     
     //Letter button
     for (int i = 1; i <= 26; i++) {
     UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     button.frame = CGRectMake(0, i*sizeOfLetterButton, sizeOfLetterButton, sizeOfLetterButton);
     [button setTitle:[NSString stringWithFormat:@"%c", i+96] forState:UIControlStateNormal];
     [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     button.tag = i+96;
     [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [scrollView addSubview:button];
     }
     
     [self.view addSubview:scrollView];
     }];
     */
}
- (NSMutableArray *)filterCurrentWords:(NSArray *)array withCharacer:(NSString *)character withIndex:(int)index{
    NSMutableArray *rtn = [NSMutableArray new];
    
    for (NSString *string in arrayOfWords) {
        if ([string characterAtIndex:index] == [character characterAtIndex:0]) {
            [rtn addObject:string];
        }
    }
    
    return rtn;
}
- (void)letterButton{
    WordLetterFilterViewController *letterViewController = [[WordLetterFilterViewController alloc] initWithNibName:nil bundle:nil];
    letterViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:letterViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navController animated:YES completion:nil];
}
- (void)setup{
    [mainTable reloadData];
    indexOfChoosen = -1;
    self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
}
/*
- (void)doPermute:(NSMutableArray *)input output:(NSMutableArray *)output used:(NSMutableArray *)used size:(int)size level:(int)level{
    if (size == level) {
        NSString *word = [output componentsJoinedByString:@""];
        if ([arrayOfWords containsObject:word]) {
            if (![results containsObject:word]) {
                [results addObject:word];
            }
        }
        return;
    }
    
    level++;
    
    for (int i = 0; i < input.count; i++) {
        
        if ([used[i] boolValue]) {
            continue;
        }
        used[i] = [NSNumber numberWithBool:YES];
        [output addObject:input[i]];
        
        if (![self carryonPermute:[output componentsJoinedByString:@""] withLevel:level]) {
            used[i] = [NSNumber numberWithBool:NO];
            [output removeLastObject];
            continue;
        }
        
        [self doPermute:input output:output used:used size:size level:level];
        //doPermute(input, output, used, size, level);
        used[i] = [NSNumber numberWithBool:NO];
        [output removeLastObject];
    }
}
- (NSArray *)getPermutations:(NSString *)input size:(int)size{
    results = [[NSMutableArray alloc] init];
    NSMutableArray *chars = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [input length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [input characterAtIndex:i]];
        [chars addObject:ichar];
    }
    
    NSMutableArray *output = [[NSMutableArray alloc] init];
    NSMutableArray *used = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < chars.count; i++) {
        [used addObject:[NSNumber numberWithBool:NO]];
    }
    
    [self doPermute:chars output:output used:used size:size level:0];
    //NSLog(@"%@", results);
    return results;
}
- (BOOL)carryonPermute:(NSString *)output withLevel:(int)level{
    BOOL rtn = NO;
    
    for (NSString *string in arrayOfWords) {
        //NSLog(@"%@ %@", [string substringWithRange:NSMakeRange(0, level)], output);
        
        if ([[string substringWithRange:NSMakeRange(0, level)] isEqualToString:output]) {
            rtn = YES;
            break;
        }
    }
    
    return rtn;
}
 */
- (void)filterWordsByString:(NSString *)string{
    NSMutableArray *results = [NSMutableArray arrayWithArray:arrayOfWords];
    [arrayOfWords removeAllObjects];
    [self setup];
    
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
            int64_t delayInSeconds = 1.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [arrayOfWords addObject:word];
                [self setup];
            });
        }
    }
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
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    //Remove UILabel
    for (UILabel *label in [cell.contentView subviews]) {
        [label removeFromSuperview];
    }
    
    //Add letter
    float width = kScreenWidth/(float)self.sizeOfWord;
    
    for (int i = 0; i < self.sizeOfWord; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, mainTable.rowHeight)];
        label.text = [[arrayOfWords objectAtIndex:indexPath.row] substringWithRange:NSMakeRange(i, 1)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    
    //cell.contentView.backgroundColor = (indexPath.row%2==0)?[UIColor clearColor]:[UIColor lightGrayColor];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WordDefinitionViewController *definitionViewController = [[WordDefinitionViewController alloc] initWithNibName:nil bundle:nil];
    definitionViewController.string = [arrayOfWords objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:definitionViewController animated:YES];
}

#pragma mark - UIView touch event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"began touch");
    
    if (!isLocked) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchLocation = [touch locationInView:self.view];
        
        //calculate xStart position
        float xStart = 0;
        float width = kScreenWidth/(float)self.sizeOfWord;
        
        for (int i = 0; i < self.sizeOfWord; i++) {
            if (touchLocation.x > width*i && touchLocation.x < width*i + width) {
                xStart = width*i;
                indexOfChoosen = i;
                break;
            }
        }
        
        verticalView = [[UIView alloc] initWithFrame:CGRectMake(xStart, 0, width, kContentHeight)];
        verticalView.backgroundColor = RGB255Alpha(255,255,0,0.3);
        [self.view addSubview:verticalView];
        
        [self performSelector:@selector(fireLongPress) withObject:nil afterDelay:longPressTime];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"move touch");
    
    if (!isLocked) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint touchLocation = [touch locationInView:self.view];
        
        //calculate xStart position
        float xStart = 0;
        float width = kScreenWidth/(float)self.sizeOfWord;
        
        for (int i = 0; i < self.sizeOfWord; i++) {
            if (touchLocation.x > width*i && touchLocation.x <= width*i + width) {
                xStart = width*i;
                indexOfChoosen = i;
                break;
            }
        }
        
        if (xStart != verticalView.frame.origin.x) {
            [verticalView removeFromSuperview];
            
            verticalView = [[UIView alloc] initWithFrame:CGRectMake(xStart, 0, width, kContentHeight)];
            verticalView.backgroundColor = RGB255Alpha(255,255,0,0.3);
            [self.view addSubview:verticalView];
            
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
            [self performSelector:@selector(fireLongPress) withObject:nil afterDelay:longPressTime];
        }
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"end touch");
    [verticalView removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (!isLocked) {
        indexOfChoosen = -1;
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"cancel touch");
    indexOfChoosen = -1;
}

#pragma mark - LetterFilter delegate
- (void)getLetterFilter:(NSString *)string{
    NSLog(@"%@", string);
    if ([string length] < self.sizeOfWord) {
        [arrayOfWords removeAllObjects];
        [self setup];
        return;
    }
    
    [self defaultArrayOfWords];
    stringFilterFromModalView = string;
}

@end

