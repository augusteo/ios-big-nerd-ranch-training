//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

+ (BNRItemStore *)sharedStore;

@property (nonatomic, strong, readonly) NSArray *allItems;

- (BNRItem *)createItem;

@end