//
//  Person.m
//  BMITime
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize heightInMeters, weightInKilos;

- (float)bodyMassIndex {
  float h = [self heightInMeters];
  return [self weightInKilos] / (h * h);
}

@end
