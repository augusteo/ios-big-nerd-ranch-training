//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Employee.h"
#import "Asset.h"


@implementation Employee

@synthesize employeeId, spouse, children;

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@ %@>", firstName, lastName];
}

- (void)addAssetObject:(Asset *)a {
  // Is assets nil?
  if (!assets) {
    assets = [[NSMutableArray alloc] init];
  }

  // Check is asset before adding
  if ([a isKindOfClass:[Asset class]]) {
    [assets addObject:a];
    [a setHolder:self];
  }
}

- (unsigned int)vauleOfAssets {
  // Sum up the resale value of assets
  unsigned int sum = 0;
  for (Asset *asset in assets) {
    sum += [asset resaleValue];
  }

  return sum;
}

- (void)dealloc {
  NSLog(@"Deallocating %@", self);
}

@end