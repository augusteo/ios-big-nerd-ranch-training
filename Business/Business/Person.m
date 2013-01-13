//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Person.h"


@implementation Person

- (id)init {
  return [self initWithFirstName:@"" lastName:@""];
}

- (id)initWithFirstName:(NSString *)fn lastName:(NSString *)ln {
  self = [super init];
  if (self) {
    [self setFirstName:fn];
    [self setLastName:ln];
  }

  return self;
}

@end