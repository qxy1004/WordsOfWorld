//
//  AppDelegate.m
//  WordsOfWorld
//
//  Created by Brian Quan on 10/07/2013.
//  Copyright (c) 2013 Brian Quan. All rights reserved.
//

#import "AppDelegate.h"

#import "WordDictionaryViewController.h"
#import "WordPuzzleHelperViewController.h"
#import "WordStatisticsViewController.h"
#import "WordMasterViewController.h"
#import "SettingsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    //UINavicagionBar text
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], UITextAttributeTextColor,
      [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(1, 0)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Helvetica-Light" size:0.0], UITextAttributeFont,
      nil]];
    //UIBar text
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0], UITextAttributeTextColor,
      [UIColor colorWithRed:51/255.0 green:153/255.0 blue:255.0/255.0 alpha:1.0], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Helvetica" size:0.0], UITextAttributeFont,
      nil] forState:UIControlStateNormal];
    //
    [[UISearchBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Override point for customization after application launch.
    WordDictionaryViewController *wordDictionaryViewController = [[WordDictionaryViewController alloc] initWithNibName:nil bundle:nil];
    WordPuzzleHelperViewController *wordPuzzleHelperViewController = [[WordPuzzleHelperViewController alloc] initWithNibName:nil bundle:nil];
    WordStatisticsViewController *wordStatisticsViewController = [[WordStatisticsViewController alloc] initWithNibName:nil bundle:nil];
    WordMasterViewController *wordMasterViewcontroller = [[WordMasterViewController alloc] initWithNibName:nil bundle:nil];
    SettingsViewController *settingsViewcontroller = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
    
    UINavigationController *dictionaryNav = [[UINavigationController alloc] initWithRootViewController:wordDictionaryViewController];
    UINavigationController *puzzleHelperNav = [[UINavigationController alloc] initWithRootViewController:wordPuzzleHelperViewController];
    UINavigationController *statisticsNav = [[UINavigationController alloc] initWithRootViewController:wordStatisticsViewController];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:wordMasterViewcontroller];
    UINavigationController *settingsNav = [[UINavigationController alloc] initWithRootViewController:settingsViewcontroller];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[dictionaryNav, puzzleHelperNav, statisticsNav, masterNav, settingsNav];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
