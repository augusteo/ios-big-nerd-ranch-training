//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "DetailViewController.h"
#import "HomePwnerItemCell.h"
#import "Constants.h"

@interface ItemsViewController ()

@property(nonatomic, strong) IBOutlet UIView *headerView;

- (IBAction)addNewItem:(id)sender;

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

  // Set the text on the cell with the description of the item
  // that is at the nth index of items, where n = row this cell
  // will appear in on the table view
  BNRItem *item = [[[BNRItemStore sharedStore] allItems] objectAtIndex:[indexPath row]];

  // Get the new or recycled cell
  HomePwnerItemCell *cell = [tableView dequeueReusableCellWithIdentifier:kItemsUITableCell];

  // Configure the cell with the BNRItem
  [[cell nameLabel] setText:[item itemName]];
  [[cell serialNumberLabel] setText:[item serialNumber]];
  [[cell valueLabel] setText:[NSString stringWithFormat:@"$%d", [item valueInDollars]]];

  [[cell thumbnailView] setImage:[item thumbnail]];

  return cell;

}

- (IBAction)addNewItem:(id)sender {
  /// Create a new BNRItem and add it to the store
  BNRItem *newItem = [[BNRItemStore sharedStore] createItem];

  DetailViewController *detailViewController = [[DetailViewController alloc] initForViewItem:YES];

  [detailViewController setItem:newItem];

  [detailViewController setDismissBlock:^{
    [[self tableView] reloadData];
  }];

  UINavigationController *navController = [[UINavigationController alloc]
      initWithRootViewController:detailViewController];

  [navController setModalPresentationStyle:UIModalPresentationFormSheet];

  [self presentViewController:navController animated:YES completion:nil];
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

  DetailViewController *detailViewController = [[DetailViewController alloc] initForViewItem:NO];

  NSArray *items = [[BNRItemStore sharedStore] allItems];
  BNRItem *selectedItem = [items objectAtIndex:[indexPath row]];

  // Give detail view controller a pointer to the item object in row
  [detailViewController setItem:selectedItem];

  // Push it onto the top of the navigation controller's stack
  [[self navigationController] pushViewController:detailViewController animated:YES];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Load the nib
  UINib *nib = [UINib nibWithNibName:kItemsUITableCell bundle:nil];

  // Register this NIB which contains the cell
  [[self tableView] registerNib:nib forCellReuseIdentifier:kItemsUITableCell];

}

- (void)viewDidAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[self tableView] reloadData];
}
@end