//
//  main.m
//  Business
//
//  Created by Ryan Blunden on 01/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>
#import "Employee.h"
#import "Asset.h"

int main(int argc, const char *argv[]) {

  @autoreleasepool {
    // Playing around with dealloc
//      Person *spouse = [[Person alloc] init];
//      spouse.firstName = @"Jacqui";
//      spouse.lastName = @"Limberger";
//
//      Employee *manager = [[Employee alloc] init];
//      manager.employeeId = 1;
//      manager.firstName = @"Ryan";
//      manager.lastName = @"Blunden";
//      manager.spouse = spouse;
//
//      Asset *harley = [[Asset alloc] init];
//      harley.label = @"Nightrod 2013";
//      harley.resaleValue = 20000;
//      [manager.assets addObject:harley];
//
//      harley = nil;
//      manager.assets = nil;
//      [manager.assets removeObjectAtIndex:0];

    // Get names
    NSString *nameString = [NSString stringWithContentsOfFile:@"/usr/share/dict/propernames" encoding:NSUTF8StringEncoding error:NULL];
    NSArray *names = [nameString componentsSeparatedByString:@"\n"];

    // Create an array of Employee objects
    NSMutableArray *employees = [[NSMutableArray alloc] init];

    // Create an asset register store
    NSMutableArray *allAssets = [[NSMutableArray alloc] init];

    for (int i = 0; i < 10; i++) {

      // Create an instance of Employee
      Employee *employee = [[Employee alloc] init];

      // Add employee to employee array
      [employees addObject:employee];

      employee.employeeId = arc4random() % 6;
      employee.firstName = [names objectAtIndex:arc4random() % [names count]];
      employee.lastName = [names objectAtIndex:arc4random() % [names count]];

      // Give this employee some assets
      int numberAssets = 1 + arc4random() % 5;
      for (int j = 0; j < numberAssets; j++) {
        Asset *asset = [[Asset alloc] init];
        [asset setLabel:[NSString stringWithFormat:@"Laptop: %d", j]];
        [asset setResaleValue:j * 17];

        [employee addAssetObject:asset];

        [allAssets addObject:asset];
      }
    }

    NSLog(@"%@", allAssets);

    // Remove one employee
    // When we remove this employee, it is de-allocated because it no longer has an owner
    [employees removeObjectAtIndex:4];

    // Remove all employees and assets - triggers de-allocation of all remaining employees adn their assets
    employees = nil;
    allAssets = nil;
  }

  return 0;
}
