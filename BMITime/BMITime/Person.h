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

// You will be able to set those instance cariables useing these methods
- (float)heightInMeters;
- (void)setHeightInMeters:(float)h;
- (int)weightInKilos;
- (void)setWeightInKilos:(int)w;

// This method calculates the Body Mass Inde
- (float)bodyMassIndex;
@end
