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
    for(int i = 0; i < 100; i++) {
      [[BNRItemStore sharedStore] createItem];
    }
  }

  return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
  return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  // Check for a reusable cell first, use that if it exists
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kItemsUITableCell];

  // If there is no reusable cell fo this type, create a new one
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kItemsUITableCell];
  }


  // Set the text on the cell with the description of the item
  // that is at the nth index of items, where n = row this cell
  // will appear in on the tableview
  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItem *p = [items objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[p description]];

  return cell;

}
@end