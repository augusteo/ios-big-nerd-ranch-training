//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RSSChannel;
@class WebViewController;

// WTF is this?
typedef enum {
  ListViewControllerRSSTypeBNR,
  ListViewControllerRSSTypeApple
} ListViewControllerRSSType;

@interface ListViewController : UITableViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate> {
  NSURLConnection *connection;
  NSMutableData *xmlData;

  RSSChannel *channel;
  ListViewControllerRSSType rssType;
}

@property(nonatomic, strong) WebViewController *webViewController;

- (void)fetchEntries;

@end

@protocol ListViewControllerDelegate
// Classes that conform to this protocol must implement this method
- (void)listViewController:(ListViewController *)lvc handleObject:(id)object;

@end