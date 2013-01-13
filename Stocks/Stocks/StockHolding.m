//
//  StockHolding.m
//  Stocks
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

@synthesize currentSharePrice, purchaseSharePrice, numberOfShares, name;

- (id)init {
  self = [super init];
  return [self initWithShareName:@"_" numberOfShares:0 purchasePrice:0 currentSharePrice:0];
}

- (id)initWithShareName:(NSString *)nme
         numberOfShares:(int)n
          purchasePrice:(float)pp
      currentSharePrice:(float)cp {
  
  self = [super init];
  // If self was nil, our class has no memory location assigned, abort init
  if(self) {
    self.name = nme;
    self.numberOfShares = n;
    self.purchaseSharePrice = pp;
    self.currentSharePrice = cp;
  }
  
  return self;
}

- (float)costInDollars {
  return self.numberOfShares * self.purchaseSharePrice;
}

- (float)valueInDollars {
  return self.numberOfShares * self.currentSharePrice;
}

@end
