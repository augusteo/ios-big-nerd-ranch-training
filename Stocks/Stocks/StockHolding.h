//
//  StockHolding.h
//  Stocks
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockHolding : NSObject
{
  NSString *name;
  float purchseSharePrice;
  float currentSharePrice;
  int numberOfShares;
}

@property NSString *name;
@property float purchaseSharePrice;
@property float currentSharePrice;
@property int numberOfShares;

- (id)init;
- (id)initWithShareName:(NSString *)nme
         numberOfShares:(int)n
          purchasePrice:(float)pp
      currentSharePrice:(float)cp;
- (float)costInDollars;
- (float)valueInDollars;

@end
