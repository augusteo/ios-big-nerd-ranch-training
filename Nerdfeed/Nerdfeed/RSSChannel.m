//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RSSChannel.h"
#import "RSSItem.h"


@implementation RSSChannel {
  NSMutableString *currentString;
}

- (id)init {
  self = [super init];
  if (self) {
    _items = [[NSMutableArray alloc] init];
  }

  return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

  if ([elementName isEqual:@"title"]) {
    currentString = [[NSMutableString alloc] init];
    [self setTitle:currentString];
  }
  else if ([elementName isEqual:@"description"]) {
    currentString = [[NSMutableString alloc] init];
    [self setInfoString:currentString];
  }
  else if ([elementName isEqual:@"item"] || [elementName isEqual:@"entry"]) {
    // When we find an item, create an instance of an RSSItem
    RSSItem *entry = [[RSSItem alloc] init];

    // Set up its parent as ourselves so we can regain control o the parser
    [entry setParentParserDelegate:self];

    // turn the parser to the RSSItem
    [parser setDelegate:entry];

    // Add the item to our array and release our hold on it
    [[self items] addObject:entry];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  [currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  // If we were in an element that we wre collecting the string for, this appropriate releases our hold on it and
  // the permanent ivar keeps ownership of it. If we weren't parsing such an element, the currentString is nil already.
  currentString = nil;

  // if the element that was eneded was the channel, give up control to who gave us control in the first place
  if ([elementName isEqual:@"channel"]) {
    [parser setDelegate:_parentParserDelegate];
  }
}

- (void)readFromJSONDictionary:(NSDictionary *)d {
  // The top-level object contains a "feed: obhect which is the channel
  NSDictionary *feed = d[@"feed"];

  // The feed has a title property, make this the title of our channel
  [self setTitle:feed[@"feed"]];

  // The feed also has an array of entries, for each one, make a new RSSItem.
  NSArray *entries = feed[@"entry"];
  for (NSDictionary *entry in entries) {
    RSSItem *i = [[RSSItem alloc] init];

    // Pass the entry dictionary to the item so it can grab its ivars
    [i readFromJSONDictionary:entry];
  }
}


@end