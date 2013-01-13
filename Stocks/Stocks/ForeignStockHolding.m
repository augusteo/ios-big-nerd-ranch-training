//
//  ForeignStockHolding.m
//  Stocks
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import "ForeignStockHolding.h"

@implementation ForeignStockHolding

@synthesize conversionRate;

- (id)initWithShareName:(NSString *)nme
         numberOfShares:(int)n
          purchasePrice:(float)pp
      currentSharePrice:(float)cp
         conversionRate:(float)cr {
  self = [self initWithShareName:nme numberOfShares:pp purchasePrice:cp currentSharePrice:pp];
  self.conversionRate = cr;
  return self;
}

- (float)costInDollars {
  float cost = [super costInDollars];
  return cost * self.conversionRate;
}

- (float)valueInDollars {
  float value = [super valueInDollars];
  return value * self.conversionRate;
}

@end
