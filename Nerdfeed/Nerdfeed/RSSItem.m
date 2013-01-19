//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RSSItem.h"


@implementation RSSItem {

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

  if ([elementName isEqual:@"title"]) {
    currentString = [[NSMutableString alloc] init];
    [self setTitle:currentString];
  }
  else if ([elementName isEqual:@"link"]) {
    currentString = [[NSMutableString alloc] init];
    [self setLink:currentString];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)str {
  [currentString appendString:str];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
  currentString = nil;

  if ([elementName isEqual:@"item"] || [elementName isEqual:@"entry"]) {
    [parser setDelegate:_parentParserDelegate];
  }
}

- (void)readFromJSONDictionary:(NSDictionary *)d {
  [self setTitle:d[@"title"][@"label"]];

  // Inside each entry is an array of links, each has an attribute object
  NSArray *links = d[@"link"];
  if ([links count] > 1) {
    NSDictionary *sampleDict = links[1][@"attributes"];

    // The href of an attribute object is the URK for the sample audio file
    [self setLink:sampleDict[@"href"]];
  }
}

@end