//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Asset.h"


@implementation Asset

@synthesize label, resaleValue;

- (NSString *)description {
  if ([self holder]) {
    return [NSString stringWithFormat:@"<%@: $%d, assigned to %@>", [self label], [self resaleValue], [self holder]];
  }
  else {
    return [NSString stringWithFormat:@"<%@: $%d>", [self label], [self resaleValue]];
  }
}

- (void)dealloc {
  NSLog(@"Deallocating %@", self);
}
@end