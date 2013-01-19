//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "JSONSerializable.h"


@interface RSSChannel : NSObject <NSXMLParserDelegate, JSONSerializable>

@property(nonatomic, weak) id parentParserDelegate;

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *infoString;
@property(nonatomic, readonly, strong) NSMutableArray *items;

@end