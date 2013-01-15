//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Constants.h"

@interface ItemsViewController : UITableViewController <UITableViewDataSource> {
  NSMutableArray *cheapItems;
  NSMutableArray *otherItems;
}
@end