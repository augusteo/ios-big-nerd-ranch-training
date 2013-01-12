//
//  main.m
//  TimeAfterTime
//
//  Created by Ryan Blunden on 1/12/13.
//
//

#import <Foundation/Foundation.h>
#include <stdarg.h>
#include <stdio.h>

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    // Get date components
    int numberInput;
    NSLog(@"Enter your birth day:");
    scanf("%d",&numberInput);
    [comps setDay:numberInput];
    
    NSLog(@"Enter your birth month:");
    scanf("%d",&numberInput);
    [comps setMonth:numberInput];
    
    NSLog(@"Enter your birth year:");
    scanf("%d",&numberInput);
    [comps setYear:numberInput];
      
    NSDate *now = [NSDate date];
    NSLog(@"The new date lives at %@", now);
    
    double seconds = [now timeIntervalSince1970];
    NSLog(@"It has ben %f seconds since the start of 1970.", seconds);
    
    NSDate *later = [now dateByAddingTimeInterval:100000];
    NSLog(@"In 100,000 seconds, it will be %@", later);
    
    
    NSCalendar *g = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dateOfBirth = [g dateFromComponents:comps];
    
    NSLog(@"Your birth date is %@", dateOfBirth);
    NSLog(@"It has been %f seconds since your birth", [now timeIntervalSinceDate:dateOfBirth]);    
    
  }
    return 0;
}

