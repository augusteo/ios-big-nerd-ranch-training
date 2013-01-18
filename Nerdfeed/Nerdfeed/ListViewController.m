//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"
#import "ChannelViewController.h"
#import "BNRFeedStore.h"


@implementation ListViewController {

}

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Info"
                                                            style:UIBarButtonItemStyleBordered target:self
                                                           action:@selector(showInfo:)];
    [[self navigationItem] setRightBarButtonItem:bbi];

    UISegmentedControl *rssTypeControl = [[UISegmentedControl alloc] initWithItems:@[@"BNR", @"Apple"]];
    [rssTypeControl setSelectedSegmentIndex:0];
    [rssTypeControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [rssTypeControl addTarget:self action:@selector(changeType:)
             forControlEvents:UIControlEventValueChanged];
    [[self navigationItem] setTitleView:rssTypeControl];

    [self fetchEntries];
  }

  return self;
}

- (void)changeType:(id)sender {
  rssType = [sender selectedSegmentIndex];
  [self fetchEntries];
}

- (void)showInfo:(id)showInfo {
  // Create the channel view controller
  ChannelViewController *channelViewController = [[ChannelViewController alloc] initWithStyle:UITableViewStyleGrouped];

  if ([self splitViewController]) {
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:channelViewController];

    // Grab a pointer to the split view controller and reset its view controllers array
    [[self splitViewController] setViewControllers:@[[self navigationController], nvc]];

    // Make detail view controller the delegate of the split view controller and reset its view controllers array
    [[self splitViewController] setDelegate:channelViewController];

    // If a row has been selected, delesect it so that a row is not slected when viewing the info
    NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
    if (selectedRow) {
      [[self tableView] deselectRowAtIndexPath:selectedRow animated:YES];
    }
  }
  else {
    [[self navigationController] pushViewController:channelViewController animated:YES];
  }

  // Give the VC the channel object through the protocol message
  [channelViewController listViewController:self handleObject:channel];
}

- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[channel items] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableView"];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"UITableView"];
  }
  RSSItem *item = [channel items][[indexPath row]];
  [[cell textLabel] setText:[item title]];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (![self splitViewController]) {
    [[self navigationController] pushViewController:_webViewController animated:YES];
  }
  else {
    // We have to create a new navigation controller, as the old one was retained by the split view controller as is
    // now gone
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_webViewController];

    [[self splitViewController] setViewControllers:@[[self navigationController], nav]];

    // Make the detail view controller the dlegate of the split view controller
    [[self splitViewController] setDelegate:_webViewController];
  }

  // Grab the selected item
  RSSItem *entry = [channel items][[indexPath row]];

  [_webViewController listViewController:self handleObject:entry];
}

- (void)fetchEntries {
  void (^completionBlock)(RSSChannel *obj, NSError *err) =
      ^(RSSChannel *obj, NSError *err) {
        // When the request completes, this block will be called

        if (!err) {
          // If everything went ok, grab the channel object and reload the table
          channel = obj;

          [[self tableView] reloadData];
        }
        else {
          // If things went bad...
          UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"error" message:[err localizedDescription]
                                                      delegate:nil cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
          [av show];
        };
      };

  // Initiate the request
  if (rssType == ListViewControllerRSSTypeBNR) {
    [[BNRFeedStore sharedStore] fetchRSSFeedWithCompletion:completionBlock];
  }
  else if (rssType == ListViewControllerRSSTypeApple) {
    [[BNRFeedStore sharedStore] fetchTopSongs:10
                               withCompletion:completionBlock];
  }
}

@end