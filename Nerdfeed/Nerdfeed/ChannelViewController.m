//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ChannelViewController.h"
#import "RSSChannel.h"


@implementation ChannelViewController {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableView"];

  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                  reuseIdentifier:@"UITableViewCell"];
  }

  if ([indexPath row] == 0) {
    // Put the title of the channel in row 0
    [[cell textLabel] setText:@"Title"];;
    [[cell detailTextLabel] setText:[channel title]];
  }
  else {
    // Put the description of the channel in row 1
    [[cell textLabel] setText:@"Info"];
    [[cell detailTextLabel] setText:[channel infoString]];
  }

  return cell;
}

- (NSUInteger)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
  return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)listViewController:(ListViewController *)lvc handleObject:(id)object {
  // If we are in portrait mode, provide a button to show the split pane view menu as it disappears when
  // clicking on the nav bar
  if (UIDeviceOrientationIsPortrait([self interfaceOrientation])) {

  }

  // Make sure the ListViewController gave us the right object
  if (![object isKindOfClass:[RSSChannel class]]) {
    return;
  }

  channel = object;

  [[self tableView] reloadData];
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
  [barButtonItem setTitle:@"List"];

  [[self navigationItem] setLeftBarButtonItem:barButtonItem];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
  if (barButtonItem == [[self navigationItem] leftBarButtonItem]) {
    [[self navigationItem] setLeftBarButtonItem:nil];
  }
}
@end