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

  if ([elementName isEqual:@"item"]) {
    [parser setDelegate:_parentParserDelegate];
  }
}
@end