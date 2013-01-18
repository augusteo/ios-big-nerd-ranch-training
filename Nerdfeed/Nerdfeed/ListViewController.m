//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ListViewController.h"
#import "RSSChannel.h"
#import "RSSItem.h"
#import "WebViewController.h"


@implementation ListViewController {

}

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    [self fetchEntries];
  }

  return self;
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
  // Push the web view controller onto the navigation stack - this implicitly creates the web view controller's view
  // the first time through
  [[self navigationController] pushViewController:_webViewController animated:YES];

  // Grab the selected item
  RSSItem *entry = [channel items][[indexPath row]];

  // Construct a URL with the link string of the item
  NSURL *url = [NSURL URLWithString:[entry link]];

  // Construct a request object with that URL
  NSURLRequest *req = [NSURLRequest requestWithURL:url];

  // Load the request into the web view
  [[_webViewController webView] loadRequest:req];

  // Set the title of the web view controller's navigation item
  [[_webViewController navigationItem] setTitle:[entry title]];
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