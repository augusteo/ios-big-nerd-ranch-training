//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;


@interface ListViewController : UITableViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate> {
  NSURLConnection *connection;
  NSMutableData *xmlData;

  RSSChannel *channel;
}

@property(nonatomic, strong) WebViewController *webViewController;

- (void)fetchEntries;

@end