//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore () {
  NSMutableArray *_allItems;
}

@end

@implementation BNRItemStore
@synthesize allItems = _allItems;

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
    NSString *path = [self itemArchivePath];
    _allItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    // If the array hadn't been saved previously, create a new empty one
    if (!_allItems) {
      _allItems = [[NSMutableArray alloc] init];
    }
  }

  return self;
}

- (BNRItem *)createItem {
  BNRItem *p = [[BNRItem alloc] init];
  [_allItems addObject:p];
  return p;
}

- (void)removeItem:(BNRItem *)item {
  NSString *key = [item imageKey];
  [[BNRImageStore sharedStore] removeImageForKey:key];

  // We don't use "removeObject" here as that the message "isEqual" is sent to each object which the object can override
  // Using removeObjectIdenticalTo ensures we're removing the same object passed in
  [_allItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
  if (from == to) {
    return;
  }

  // Get item
  BNRItem *p = [_allItems objectAtIndex:from];
  [_allItems removeObjectAtIndex:from];
  [_allItems insertObject:p atIndex:to];

}

- (NSString *)itemArchivePath {
  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,
      YES);

  // Get one and only document directory from that list
  NSString *documentDirectory = [documentDirectories objectAtIndex:0];

  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges {
  // returns success or failure
  NSString *path = [self itemArchivePath];

  return [NSKeyedArchiver archiveRootObject:_allItems toFile:path];
}


@end