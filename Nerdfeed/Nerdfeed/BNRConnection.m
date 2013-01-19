//
// Created by rblunden on 1/18/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRConnection.h"


@implementation BNRConnection {

}

static NSMutableArray *sharedConnectionList = nil;

- (id)initWithRequest:(NSURLRequest *)req {
  self = [super init];
  if (self) {
    [self setRequest:req];
  }
  return self;
}

- (void)start {
  // Initialize container for data collected from NSURLConnection
  container = [[NSMutableData alloc] init];

  // Spawn connection
  internalConnection = [[NSURLConnection alloc] initWithRequest:[self request] delegate:self
                                               startImmediately:YES];

  // If this is the first connection started, create the array
  if (!sharedConnectionList) {
    sharedConnectionList = [[NSMutableArray alloc] init];

    // Add the connection to the array so it doesn't get destroyed
    [sharedConnectionList addObject:self];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [container appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  id rootObject = nil;

  // IF there is "root object"
  if ([self xmlRootObject]) {
    // Create a parser with the incoming data and let the root object parse its contents
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:container];
    [parser setDelegate:[self xmlRootObject]];
    [parser parse];

    rootObject = [self xmlRootObject];
  }
  else if ([self jsonRootObject]) {
    // Turn JSON data into basic model objects
    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0
                                                        error:nil];

    // Have the root object construct itself from basic model objects
    [[self jsonRootObject] readFromJSONDictionary:d];

    rootObject = [self jsonRootObject];
  }

  // Then pass the root object to the completion block - remember, this is the block that the controller supplied
  if ([self completionBlock]) {
    [self completionBlock](rootObject, nil);
  }

  // now, destroy the connection
  [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  // Pass the error from the connection to the completion block
  if ([self completionBlock]) {
    [self completionBlock](NSIsNotNilTransformerName, error);
  }

  // Destroy the connection
  [sharedConnectionList removeObject:self];
}
@end