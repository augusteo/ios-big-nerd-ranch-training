//
//  Person.h
//  BMITime
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>

// The Person class inherits all the instance variables and methods
// defined by the class NSObject
// It has two instance variables
@interface Person : NSObject {
  float heightInMeters;
  int weightInKilos;
}

@property float heightInMeters;
@property int weightInKilos;

// This method calculates the Body Mass Inde
- (float)bodyMassIndex;
@end
