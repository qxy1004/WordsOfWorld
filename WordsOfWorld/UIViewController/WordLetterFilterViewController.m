//
//  WordLetterFilterViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 16/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordLetterFilterViewController.h"
#import "BQDefine.h"
#import <QuartzCore/QuartzCore.h>

@interface WordLetterFilterViewController (){
    UITextField *textField;
}

@end

@implementation WordLetterFilterViewController

#pragma mark - Sytem functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [textField becomeFirstResponder];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Filtering letters";
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 30)];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.backgroundColor = [UIColor clearColor];
    textField.layer.borderColor = [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
    textField.layer.borderWidth = 0.5f;
    textField.layer.cornerRadius = 10.0f;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.keyboardType = UIKeyboardTypeAlphabet;
    
    [self.view addSubview:textField];
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Done"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(doneButton)];
    self.navigationItem.rightBarButtonItem = clearButton;
}
- (void)dealloc{
#ifdef DEBUG
	NSLog(@"dealloc %@", self);
#endif
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Self functions
- (void)doneButton{
    /*
    NSMutableArray *rtn = [NSMutableArray new];
    NSString *string = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (int i = 0; i < [string length]; i++) {
        [rtn addObject:[[NSString stringWithFormat:@"%c",[string characterAtIndex:i]] lowercaseString]];
    }
     [self.delegate getLetterFilter:[rtn sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
     */
    [self.delegate getLetterFilter:[[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lowercaseString]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end