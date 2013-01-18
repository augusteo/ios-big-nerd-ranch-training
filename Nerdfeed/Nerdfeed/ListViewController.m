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


@implementation ListViewController {

}

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"Info"
                                                            style:UIBarButtonItemStyleBordered target:self
                                                           action:@selector(showInfo:)];
    [[self navigationItem] setRightBarButtonItem:bbi];
    [self fetchEntries];
  }

  return self;
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
  // Create a new data container for the stuff service data
  xmlData = [[NSMutableData alloc] init];

  // Apple's hot feed
  NSURL *url = [NSURL URLWithString:@"http://www.apple.com/pr/feeds/pr.rss"];

  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  connection = [[NSURLConnection alloc] initWithRequest:req delegate:self
                                       startImmediately:YES];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data {
  // Add the incoming chunk of data to the container we are keeping
  // The date always comes in the correct order
  [xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
  // Create the parser object
  NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];

  // Give it a delegate - ignore the warning here for now
  [parser setDelegate:self];

  // Start parsing - the document will be parsed and the delegate of NSXMLPArser will get all of its delegate
  // messages sent to it before this line finishes execution - it is blocking
  [parser parse];

  // Get rid of the XML data as we no longer need it
  xmlData = nil;

  // Get rid of connection, we longer need it
  connection = nil;

  // Reload the table... for now, the table will be empty
  [[self tableView] reloadData];
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error {
  // Release the connection object, we're done with it
  connection = nil;

  // Release the xmlData object, we're done
  xmlData = nil;

  // Grab the description of the error passed to us
  NSString *errorString = [NSString stringWithFormat:@"Fetch failed %@", [error localizedDescription]];

  // Create and show an alert view with this error displayed
  UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString
                                              delegate:nil cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
  [av show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {

  // If the parser saw a channel, create a new instance, store in our ivar
  channel = [[RSSChannel alloc] init];

  // Give the channel object ap ointer back to ourselves for later
  [channel setParentParserDelegate:self];

  // Set the parser's dleedate to the channel object
  // THere will be a warning here, ignore for now
  [parser setDelegate:channel];
}

@end