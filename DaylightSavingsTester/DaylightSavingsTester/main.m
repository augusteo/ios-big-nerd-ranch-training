//
//  main.m
//  DaylightSavingsTester
//  Having fun with nested messages
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    
    bool isDST = [[NSTimeZone systemTimeZone] isDaylightSavingTime];
    NSLog(@"Is it Daylight Savings Time? Computer says %@", isDST ? @"Yes" : @"No");
    
  }
    return 0;
}

