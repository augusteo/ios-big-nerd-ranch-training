//
//  main.m
//  Stocks
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockHolding.h"
#import "ForeignStockHolding.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    StockHolding *bhp = [[StockHolding alloc] init];
    bhp.name = @"BHP";
    bhp.currentSharePrice = 55.87;
    bhp.purchaseSharePrice = 56.55;
    bhp.numberOfShares = 1099;
    
    StockHolding *amp = [[StockHolding alloc] initWithShareName:@"AMP" numberOfShares:2010 purchasePrice:20 currentSharePrice:19.8];
    
    ForeignStockHolding *suncorp = [[ForeignStockHolding alloc] initWithShareName:@"SCP"
                                                                   numberOfShares:1028
                                                                    purchasePrice:5.5 currentSharePrice:5.3
                                                                   conversionRate:1.1];
    
    
    NSArray *shares = [[NSArray alloc] initWithObjects:bhp, amp, suncorp, nil];

    // We cannnot use dot syntax in this loop because all the compiler knows is that we're iterating over in array
    // with each type being an id (an int)
    for(id share in shares) {
      NSLog(@"%@ shares are worth $%.2f", [share name], [share valueInDollars]);
    }
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // We know that every share is an instance or subclass of StockHolding which is why we can use dot syntax
    // Technically, we could use any type of class reference as long as the properties accessed were avaiable on the class
    // This is because this a compile time check, not a run time check.
    for(StockHolding *share in shares) {
      NSLog(@"%@ shares are worth %@", share.name, [currencyFormatter stringFromNumber:[[NSNumber alloc] initWithFloat:share.valueInDollars]]);
    }
    
  }
    return 0;
}

