//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "DetailViewController.h"

@interface ItemsViewController ()

@property(nonatomic, strong) IBOutlet UIView *headerView;

- (IBAction)addNewItem:(id)sender;

- (IBAction)toggleEditingMode:(id)sender;

@end

@implementation ItemsViewController

- (id)init {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    UINavigationItem *n = [self navigationItem];
    [n setTitle:@"Homepwner"];

    // Create a new bar button item that will send addNewItem: to ItemsViewController
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self action:@selector(addNewItem:)];

    // Set this bar button item as the right item in the navigationItem
    [[self navigationItem] setRightBarButtonItem:bbi];

    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
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

- (UIView *)headerView {
  // If we haven't loaded the header view yet
  if (!_headerView) {
    [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
  }

  return _headerView;
}

- (UIView *)tableView:(UITableView *)tv viewForHeaderInSection:(NSInteger)sec {
  return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  // The height of the header view should be determined from the height of the view in the XIB file
  return [[self headerView] bounds].size.height;
}

- (IBAction)toggleEditingMode:(id)sender {
  // If we are curently in editing mode...
  if ([self isEditing]) {
    // Change text of button to inform user of state
    [sender setTitle:@"Edit" forState:UIControlStateNormal];

    // Turn off editing mode
    [self setEditing:NO animated:YES];
  }
  else {
    // Change text of button to inform user of state
    [sender setTitle:@"Done" forState:UIControlStateNormal];

    // Enter editing mode
    [self setEditing:YES animated:YES];
  }
}

- (IBAction)addNewItem:(id)sender {
  /// Create a new BNRItem and add it to the store
  BNRItem *newItem = [[BNRItemStore sharedStore] createItem];

  // / Figure out where that item is in the array
  int lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
  NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRow inSection:0];

  // Insert into table
  // We could get a reference to the UITableView instance by using [self view] but as this is inherited
  // from UIViewController, it has no knowledge about what type of view it is
  // Using [self tableView] tells the compiler (and your IDE) that we're dealing with a view of type UITableView
  [[self tableView] insertRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  // If the table view is asking to commit a delete command
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    BNRItemStore *ps = [BNRItemStore sharedStore];
    NSArray *items = [ps allItems];
    BNRItem *p = [items objectAtIndex:[indexPath row]];
    [ps removeItem:p];

    // we also remove that row from the table view with an animation
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
  [[BNRItemStore sharedStore] moveItemAtIndex:[sourceIndexPath row] toIndex:[toIndexPath row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  DetailViewController *detailViewController = [[DetailViewController alloc] init];

  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItemStore *selectedItem = [items objectAtIndex:[indexPath row]];

  // Give detail view controller a pointer to the item object in row
  [detailViewController setItem:selectedItem];

  // Push it onto the top of the navigation controller's stack
  [[self navigationController] pushViewController:detailViewController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[self tableView] reloadData];
}
@end