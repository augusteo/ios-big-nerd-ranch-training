//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRLine.h"


@implementation BNRLine {

}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self setBegin:[aDecoder decodeCGPointForKey:@"begin"]];
    [self setEnd:[aDecoder decodeCGPointForKey:@"end"]];
  }

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeCGPoint:_begin forKey:@"begin"];
  [aCoder encodeCGPoint:_end forKey:@"end"];
}
@end