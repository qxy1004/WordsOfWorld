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


#define longPressTime 1
#define sizeOfLetterButton 40
#define stringOfBackButton @"Back"
#define stringOfClearButton @"Clear"

@interface WordPuzzleSecondViewController () <UITableViewDataSource, UITableViewDelegate>{
    UITableView *mainTable;
    NSArray *arrayOfWords;
    UIView *verticalView;
    
    RNBlurModalView *modal;
    BOOL isLocked;
    
    int indexOfChoosen;
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
    [self.tabBarController setHidden:YES];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    arrayOfWords = [WWCoreFunction loadWords:[NSString stringWithFormat:@"%d", self.sizeOfWord]];
    self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
    self.view.backgroundColor = [UIColor blackColor];
    
    //Set up table
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenNavigationBarHeight-kScreenToolBarHeight) style:UITableViewStylePlain];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    
    //Add explain label in the bottom
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, kContentHeight-kScreenNavigationBarHeight-kScreenToolBarHeight + kScreenToolBarHeight/3.0, kScreenWidth, kScreenToolBarHeight/3.0*2)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Move and hold on this area";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:label];
    
    //Add index label in the bottom
    for (int i = 1; i <= self.sizeOfWord; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/(float)self.sizeOfWord*(i-1), kContentHeight-kScreenNavigationBarHeight-kScreenToolBarHeight, kScreenWidth/(float)self.sizeOfWord, kScreenToolBarHeight/3.0)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%d", i];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:10];
        
        [self.view addSubview:label];
    }
    
    //Set flag
    isLocked = NO;
    indexOfChoosen = -1;
    
    //Add Clear button
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc]
                                   initWithTitle:stringOfClearButton
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(clearButtonPress)];
    self.navigationItem.rightBarButtonItem = clearButton;
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
    
    isLocked = NO;
    
    UIButton *button = sender;
    
    if ([button.titleLabel.text isEqualToString:stringOfBackButton]) {
        [modal hideWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut completion:^{
            //Update UITableView
            NSLog(@"Press back button");
            indexOfChoosen = -1;
            self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
        }];
    }
    else if ([button.titleLabel.text isEqualToString:stringOfClearButton]) {
        [modal hideWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut completion:^{
            //Update UITableView
            NSLog(@"Press clear button");
            arrayOfWords = [WWCoreFunction loadWords:[NSString stringWithFormat:@"%d", self.sizeOfWord]];
            [mainTable reloadData];
            indexOfChoosen = -1;
            self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
        }];
    }
    else{
        [modal hideWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut completion:^{
            //Update UITableView
            arrayOfWords = [self filterCurrentWords:arrayOfWords withCharacer:button.titleLabel.text withIndex:indexOfChoosen];
            [mainTable reloadData];
            indexOfChoosen = -1;
            self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
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
    
    //Clear button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, sizeOfLetterButton, sizeOfLetterButton);
    [button setTitle:@"Clear" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    //Letter button
    for (int i = 0; i <= 27; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(i%8*sizeOfLetterButton, i/8*sizeOfLetterButton, sizeOfLetterButton, sizeOfLetterButton);
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
- (void)clearButtonPress{
    arrayOfWords = [WWCoreFunction loadWords:[NSString stringWithFormat:@"%d", self.sizeOfWord]];
    [mainTable reloadData];
    indexOfChoosen = -1;
    self.title = [NSString stringWithFormat:@"%d Letters (%d)", self.sizeOfWord, [arrayOfWords count]];
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
        //label.backgroundColor = (i%2==0)?[UIColor clearColor]:[UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    
    cell.contentView.backgroundColor = (indexPath.row%2==0)?[UIColor clearColor]:[UIColor lightGrayColor];
    
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



@end

