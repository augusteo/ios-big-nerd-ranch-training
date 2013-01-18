//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ListViewController.h"

@class RSSChannel;

@interface ChannelViewController : UITableViewController <ListViewControllerDelegate, UISplitViewControllerDelegate> {
  RSSChannel *channel;
}
@end