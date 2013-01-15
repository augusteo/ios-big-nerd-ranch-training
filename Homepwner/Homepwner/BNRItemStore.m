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

- (NSArray *)getItemsByLowerPriceBoundary:(int)lowerPrice upperPriceBoundary:(int)upperPrice {
  NSMutableArray *items = [[NSMutableArray alloc] init];

  for (int i = 0; i < [_allItems count]; i++) {
    BNRItem *item = [_allItems objectAtIndex:i];
    if (item.valueInDollars >= lowerPrice && item.valueInDollars <= upperPrice) {
      [items addObject:item];
    }
  }

  return [[NSArray alloc] initWithArray:items];
}

@end