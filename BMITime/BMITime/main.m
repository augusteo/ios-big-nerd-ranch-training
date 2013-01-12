//
//  main.m
//  BMITime
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    
    // Create an instance of Person
    Person *person = [[Person alloc] init];
    
    // Give the isntance variables values
    [person setWeightInKilos:100];
    [person setHeightInMeters:2];
    
    // Get the BMI
    float bmi = [person bodyMassIndex];
    NSLog(@"Person(%dKg, %fm) has a BMI is %f", person.weightInKilos, person.heightInMeters, bmi);
      
  }
    return 0;
}

