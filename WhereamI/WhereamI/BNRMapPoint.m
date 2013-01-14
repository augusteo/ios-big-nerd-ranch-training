//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRMapPoint.h"

@implementation BNRMapPoint

- (id)init {
  return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -87.39)
                            title:@"Home Town"];
}
- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t {
  self = [super init];
  if (self) {
    _coordinate = c;
    [self setTitle:t];
  }

  return self;
}

@end