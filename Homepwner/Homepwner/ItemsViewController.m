//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation ItemsViewController {

}

- (id)init {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    for(int i = 0; i < 30; i++) {
      [[BNRItemStore sharedStore] createItem];
    }

    cheapItems = [[BNRItemStore sharedStore] getItemsByLowerPriceBoundary:0 upperPriceBoundary:50];
    otherItems = [[BNRItemStore sharedStore] getItemsByLowerPriceBoundary:51 upperPriceBoundary:10000];
  }

  return self;
}

//http://randomimage.setgetgo.com/get.php?key=24&height=50&width=50&type=png

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return section == 0 ? @"Items $50 and below" : @"Items above $50";
}

- (id)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return section == 0 ? [cheapItems count] : [otherItems count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  NSInteger n = 2;
  return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  // Check for a reusable cell first, use that if it exists
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kItemsUITableCell];

  // If there is no reusable cell fo this type, create a new one
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kItemsUITableCell];
  }

  BNRItem *p = [indexPath section] == 0 ?
      [cheapItems objectAtIndex:[indexPath row]] :
      [otherItems objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[p description]];

  return cell;
}
@end