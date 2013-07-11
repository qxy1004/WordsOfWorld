//
//  WordStatisticsViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordStatisticsViewController.h"
#import "WWConstant.h"

@interface WordStatisticsViewController ()

@end

@implementation WordStatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = TITLE_STATISTICS;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
