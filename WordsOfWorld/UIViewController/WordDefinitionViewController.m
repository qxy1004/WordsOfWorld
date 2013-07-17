//
//  WordDefinitionViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordDefinitionViewController.h"
#import "WWDictionaryWS.h"
#import "BQDefine.h"
#import "DALinedTextView.h"
#import "UITabBarController+ShowHideBar.h"
#import "WWDefinition.h"
#import "SVProgressHUD.h"

@interface WordDefinitionViewController () <WWDictionaryWS>{
    UITextView *mainTextView;
}

@end

@implementation WordDefinitionViewController

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
    
    [SVProgressHUD showWithStatus:@"Searching..."];
    
    WWDictionaryWS *getDics = [WWDictionaryWS new];
    getDics.delegate = self;
    [getDics initWithWord:self.string];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = self.string;
    self.view.backgroundColor = [UIColor whiteColor];
    
    mainTextView = [[DALinedTextView alloc] initWithFrame:self.view.bounds];
    mainTextView.editable = NO;
    mainTextView.allowsEditingTextAttributes = YES;
    mainTextView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    mainTextView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:mainTextView];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [SVProgressHUD dismiss];
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
- (void)addTextToTextView:(NSArray *)arrayOfResult{
    NSMutableString *string = [NSMutableString new];
    
    for (WWDefinition *definition in arrayOfResult) {
        [string appendString:definition.dictionary];
        [string appendString:@":"];
        [string appendString:@"\n\n"];
        [string appendString:[self stripDoubleSpaceFrom:[definition.meaning stringByReplacingOccurrencesOfString:@"\n" withString:@""]]];
        [string appendString:@"\n\n"];
    }
    
    mainTextView.text = string;
    
    NSLog(@"%@", string);
}
- (NSString *)stripDoubleSpaceFrom:(NSString *)str {
    while ([str rangeOfString:@"  "].location != NSNotFound) {
        str = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    return str;
}

#pragma mark - WWDictionaryWS delegate
- (void)getDefinitions:(NSArray *)definitions{
    if ([definitions count] > 0) {
        [self addTextToTextView:definitions];
    }
    else{
        mainTextView.text = @"Sorry, Can not find result.";
    }
    [SVProgressHUD dismiss];
}

@end
