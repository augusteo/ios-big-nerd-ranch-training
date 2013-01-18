//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WebViewController.h"


@implementation WebViewController {

}

- (void)loadView {
// Create an instance of UIWebView as large as the screen
  CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
  UIWebView *wv = [[UIWebView alloc] initWithFrame:screenFrame];

  // Tel the web view to scale web content to fit within the bounds of the webview
  [wv setScalesPageToFit:YES];

  [self setView:wv];
}

- (UIWebView *)webView {
  return (UIWebView *) [self view];
}
@end