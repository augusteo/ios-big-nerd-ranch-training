//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "JSONSerializable.h"


@interface RSSItem : NSObject <NSXMLParserDelegate, JSONSerializable> {
  NSMutableString *currentString;
}

@property(nonatomic, weak) id parentParserDelegate;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *link;

@end