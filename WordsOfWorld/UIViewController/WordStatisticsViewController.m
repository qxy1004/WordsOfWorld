//
//  WordStatisticsViewController.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "WordStatisticsViewController.h"
#import "WWConstant.h"
#import "UITabBarController+ShowHideBar.h"
#import "BQDefine.h"
#import "WordStatisticsDetailViewController.h"
#import "WWDefine.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface WordStatisticsViewController () <MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    UITableView *mainTable;
    NSArray *arrayOfList;
}

@end

@implementation WordStatisticsViewController

#pragma mark - System functions
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = TITLE_STATISTICS;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationItem.title = @"Interesting Statistics";
    [self.tabBarController setHidden:NO];
}
- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Set up table
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kContentHeight-kScreenToolBarHeight-kScreenNavigationBarHeight) style:UITableViewStylePlain];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.backgroundColor = [UIColor clearColor];
    mainTable.backgroundView = nil;
    [self.view addSubview:mainTable];
    
    arrayOfList = [NSArray arrayWithObjects:
                    [NSArray arrayWithObjects:Title1, Detail1, nil],
                    [NSArray arrayWithObjects:Title2, Detail2, nil],
                    [NSArray arrayWithObjects:Title3, Detail3, nil],
                    [NSArray arrayWithObjects:Title4, Detail4, nil],
                    [NSArray arrayWithObjects:Title5, Detail5, nil],
                    [NSArray arrayWithObjects:Title6, Detail6, nil],
                    nil];
    
    //Add Clear button
    UIBarButtonItem *ideaButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Add"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(ideaButton)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:ideaButton, nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationItem.title = TITLE_STATISTICS;
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
- (void)ideaButton{
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:[NSArray arrayWithObjects:@"admin@xueyuan.co.uk", nil]];
        [controller setSubject:@"More statistics!"];
        
        NSMutableString *emailBody = [NSMutableString new];
        [emailBody appendString:@"Description:"];
        [emailBody appendString:@"\n\n\n\n\n\n"];
        
        [emailBody appendString:@"Help us to improve this app. Thanks in advance : )"];
        
        [controller setMessageBody:emailBody isHTML:NO];
        
        if (controller) [self presentViewController:controller animated:YES completion:nil];
    } else {
        // Handle the error
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not be able to send email. Please add email account to your iOS" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return [arrayOfList count];
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
    
    cell.textLabel.text = [[arrayOfList objectAtIndex:indexPath.row] objectAtIndex:0];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WordStatisticsDetailViewController *detailViewController = [[WordStatisticsDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailViewController.stringOfTitle = [[arrayOfList objectAtIndex:indexPath.row] objectAtIndex:0];
    detailViewController.stringOfDetails = [[arrayOfList objectAtIndex:indexPath.row] objectAtIndex:1];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
