//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Person.h"

@class Asset;

@interface Employee : Person

@property int employeeId;
@property Person *spouse;
@property NSMutableArray *children;
@property NSMutableSet *assets;

- (id)initWithEmployeeId:(int)eId;

- (void)addAssetObject:(Asset *)a;

- (unsigned int)valueOfAssets;

@end