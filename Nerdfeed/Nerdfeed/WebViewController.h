//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ListViewController.h"


@interface WebViewController : UIViewController <UIPageViewControllerDelegate, ListViewControllerDelegate, UISplitViewControllerDelegate>

@property(nonatomic, readonly, strong) UIWebView *webView;

@end