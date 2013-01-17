//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore () {

}

- (void)loadAllItems;

@end

@implementation BNRItemStore

+ (BNRItemStore *)sharedStore {
  static BNRItemStore *sharedStore = nil;
  if (!sharedStore) {
    sharedStore = [[super allocWithZone:nil] init];
  }

  return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone {
  return [self sharedStore];
}

- (id)init {
  self = [super init];
  if (self) {
    // Read in HomePwner.xcdatamodeld
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];

    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];

    // Where does the SQLite file go?
    NSString *path = [self itemArchivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];

    NSError *error = nil;

    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
      [NSException raise:@"Open failed" format:@"%@", [error localizedDescription]];
    }

    // Create the managed object context
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:psc];

    // the managed object context can manage undo but we don't need it
    [_context setUndoManager:nil];

    [self loadAllItems];
  }

  return self;
}

- (void)loadAllItems {
  if (![self allItems]) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *e = [[_model entitiesByName] objectForKey:@"BNRItem"];
    [request setEntity:e];

    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"orderingValue" ascending:YES];

    [request setSortDescriptors:@[sd]];

    NSError *error;
    NSArray *result = [_context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Fetch failed" format:@"Reason %@", [error localizedDescription]];
    }

    allItems = [[NSMutableArray alloc] initWithArray:result];
  }
}

- (BNRItem *)createItem {
  double order;
  if ([allItems count] == 0) {
    order = 1.0;
  } else {
    order = [[allItems lastObject] orderingValue] + 1.0;
  }
  NSLog(@"Adding after %d items, order = %.2f", [allItems count], order);

  BNRItem *item = [NSEntityDescription insertNewObjectForEntityForName:@"BNRItem"
                                                inManagedObjectContext:_context];

  [item setOrderingValue:order];

  [allItems addObject:item];

  return item;
}

- (void)removeItem:(BNRItem *)item {
  NSString *key = [item imageKey];
  [[BNRImageStore sharedStore] removeImageForKey:key];

  // We don't use "removeObject" here as that the message "isEqual" is sent to each object which the object can override
  // Using removeObjectIdenticalTo ensures we're removing the same object passed in
  [_context deleteObject:item];
  [allItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
  if (from == to) {
    return;
  }

  // Get item
  BNRItem *p = [allItems objectAtIndex:from];
  [allItems removeObjectAtIndex:from];
  [allItems insertObject:p atIndex:to];

  // Com[uting a nw orderValue for the object that was moved
  double lowerBound = 0.0;

  // OIs there an object before it in the array
  if (to > 0) {
    lowerBound = [[allItems objectAtIndex:to - 1] orderingValue];
  }
  else {
    lowerBound = [[allItems objectAtIndex:1] orderingValue] - 2.0;
  }

  double upperBound = 0.0;
  // Is there an object after it in the array?
  if (to < [[allItems objectAtIndex:to + 1] orderingValue]) {
    upperBound = [[allItems objectAtIndex:to + 1] orderingValue];
  }
  else {
    upperBound = [[allItems objectAtIndex:to - 1] orderingValue] + 2.0;
  }

  double newOrderValue = (lowerBound + upperBound) / 2.0;

  NSLog(@"moving to order %f", newOrderValue);
  [p setOrderingValue:newOrderValue];
}

- (NSString *)itemArchivePath {
  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

  // Get one and only document directory from that list
  NSString *documentDirectory = [documentDirectories objectAtIndex:0];

  return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges {
  NSError *err = nil;
  BOOL successful = [_context save:&err];
  if (!successful) {
    NSLog(@"Error saving %@", [err localizedDescription]);
  }

  return successful;
}

- (NSArray *)allItems {
  return allItems;
}

- (NSArray *)allAssetTypes {
  if (!allAssetTypes) {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *e = [[_model entitiesByName] objectForKey:@"BNRAssetType"];

    [request setEntity:e];

    NSError *error;
    NSArray *result = [_context executeFetchRequest:request error:&error];
    if (!result) {
      [NSException raise:@"Fetch failed" format:@"%@", [error localizedDescription]];
    }
    allAssetTypes = [result mutableCopy];
  }

  // Is this the first time the program is being run?
  if ([allAssetTypes count] == 0) {
    NSManagedObject *type;

    type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                         inManagedObjectContext:_context];
    [type setValue:@"Furniture" forKey:@"label"];
    [allAssetTypes addObject:type];

    type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                         inManagedObjectContext:_context];
    [type setValue:@"Jewelery" forKey:@"label"];
    [allAssetTypes addObject:type];

    type = [NSEntityDescription insertNewObjectForEntityForName:@"BNRAssetType"
                                         inManagedObjectContext:_context];
    [type setValue:@"Electronics" forKey:@"label"];
    [allAssetTypes addObject:type];
  }

  return allAssetTypes;
}


@end