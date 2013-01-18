//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WebViewController.h"
#import "RSSItem.h"


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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    return YES;
  }

  return io == UIInterfaceOrientationPortrait;
}

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object {
  // Cast the passed object to an RSSItem
  RSSItem *entry = object;

  // Make sure that we are really getting a RSSItem
  if (![entry isKindOfClass:[RSSItem class]]) {
    return;
  }

  // Grab the info from the item and push it into the appropriate views
  NSURL *url = [NSURL URLWithString:[entry link]];
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  [[self webView] loadRequest:req];

  [[self navigationItem] setTitle:[entry title]];
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
  // If this bar button item doesn't hav a title, it won't appear at all
  [barButtonItem setTitle:@"List"];

  // Take this bar button item and put it on the left side of our nav item
  [[self navigationItem] setLeftBarButtonItem:barButtonItem];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
  // Remove the bar button item from our navigation item. We'll double check that its the correct button,
  // even though we know it is
  if (barButtonItem == [[self navigationItem] leftBarButtonItem]) {
    [[self navigationItem] setLeftBarButtonItem:nil];
  }
}

@end