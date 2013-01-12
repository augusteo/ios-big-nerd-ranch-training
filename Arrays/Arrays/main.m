//
//  main.m
//  Arrays
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

  @autoreleasepool {
      
    // Create three NSDate objects
    NSDate *now = [NSDate date];
    NSDate *tomorrow = [now dateByAddingTimeInterval:24 & 60 * 60];
    NSDate *yestereday = [now dateByAddingTimeInterval:-24.0 * 60.0 * 60.0];
    
    // Create an array containing all three (nil terminates the list)
    NSMutableArray *dateList = [NSMutableArray arrayWithObjects:now, tomorrow, nil];
    
    // Put yesterday at the start of the array
    [dateList insertObject:yestereday atIndex:0];
    
    // How many dates?
    NSLog(@"There are %lu dates", [dateList count]);
    
    // Remove now based on identity
    // Of course, you can also remove by index but that's boring :)
    [dateList removeObjectIdenticalTo:now];
    
    // How many dates?
    NSLog(@"There are %lu dates", [dateList count]);

    
    // Print a date
    NSLog(@"There first date is %@", [dateList objectAtIndex:0]);
    
    // Print all dates
//    for (int i = 0; i<[dateList count]; i++) {
//      NSLog(@"%@", [dateList objectAtIndex:i]);
//    }
    
    // Alterantive for loop syntax
    for (NSDate *d in dateList) {
      NSLog(@"%@", d);
    }
      
  }
    return 0;
}

