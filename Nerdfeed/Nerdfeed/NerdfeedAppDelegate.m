//
//  NerdfeedAppDelegate.m
//  Nerdfeed
//
//  Created by Ryan Blunden on 01/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "NerdfeedAppDelegate.h"
#import "ListViewController.h"
#import "WebViewController.h"

@implementation NerdfeedAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.

  ListViewController *lvc = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];

  UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:lvc];

  WebViewController *wvc = [[WebViewController alloc] init];
  [lvc setWebViewController:wvc];

  // Check to make sure we're running on the iPad
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    // webViewController must be in navigation controller, you'll see why later
    UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:wvc];

    UISplitViewController *svc = [[UISplitViewController alloc] init];

    // Set the delegate of the split view controller to the detail VC. We'll need this later
    [svc setDelegate:wvc];
    [svc setViewControllers:@[masterNav, detailNav]];

    // Set the root view controller
    [[self window] setRootViewController:svc];
  }
  else {
    // On non-iPad devices, go with old version, just add the single nav controller to the window
    [[self window] setRootViewController:masterNav];
  }

  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

- (void)fetchEntries {

}


@end