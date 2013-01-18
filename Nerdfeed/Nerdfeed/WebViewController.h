//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface WebViewController : UIViewController <UIPageViewControllerDelegate>

@property(nonatomic, readonly, strong) UIWebView *webView;

@end