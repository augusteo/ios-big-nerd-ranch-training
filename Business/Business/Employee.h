//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Person.h"

@class Asset;

@interface Employee : Person {
  int employeeId;
  Person *spouse;
  NSMutableArray *children;
  NSMutableArray *assets;
}

@property int employeeId;
@property Person *spouse;
@property NSMutableArray *children;

- (void)addAssetObject:(Asset *)a;

- (unsigned int)vaueOfAssets;

@end