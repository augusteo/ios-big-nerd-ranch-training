//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Employee.h"
#import "Asset.h"


@implementation Employee

- (id)initWithEmployeeId:(int)eId {
  self = [super init];
  if (self) {
    [self setEmployeeId:eId];
  }

  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@ %@ - $%d>", [self firstName], [self lastName], [self valueOfAssets]];
}

- (void)addAssetObject:(Asset *)a {
  // Is assets nil?
  if (![self assets]) {
    [self setAssets:[[NSMutableSet alloc] init]];
  }

  // Check is asset before adding
  if ([a isKindOfClass:[Asset class]]) {
    [[self assets] addObject:a];
    [a setHolder:self];
  }
}

- (unsigned int)valueOfAssets {
  // Sum up the resale value of assets
  unsigned int sum = 0;
  for (Asset *asset in [self assets]) {
    sum += [asset resaleValue];
  }

  return sum;
}

- (void)dealloc {
  NSLog(@"Deallocating %@", self);
}

@end