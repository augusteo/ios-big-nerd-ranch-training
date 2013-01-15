//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRItemStore.h"
#import "BNRItem.h"

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
    _allItems = [[NSMutableArray alloc] init];
  }

  return self;
}

- (BNRItem *)createItem {
  BNRItem *p = [BNRItem randomItem];

  [_allItems addObject:p];

  return p;
}

- (void)removeItem:(BNRItem *)item {
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

@end