//
//  ForeignStockHolding.h
//  Stocks
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockHolding.h"

@interface ForeignStockHolding : StockHolding
{
  float conversionRate;
}

@property float conversionRate;

- (id)initWithShareName:(NSString *)nme
         numberOfShares:(int)n
          purchasePrice:(float)pp
      currentSharePrice:(float)cp
         conversionRate:(float)cr;


@end
