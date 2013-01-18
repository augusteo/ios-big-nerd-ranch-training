//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RSSChannel;


@interface ListViewController : UITableViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate> {
  NSURLConnection *connection;
  NSMutableData *xmlData;

  RSSChannel *channel;
}

- (void)fetchEntries;

@end