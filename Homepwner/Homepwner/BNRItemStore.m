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

@end