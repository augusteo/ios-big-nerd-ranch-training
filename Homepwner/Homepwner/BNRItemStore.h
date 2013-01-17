//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BNRItem;

@interface BNRItemStore : NSObject {
  NSMutableArray *allItems;
  NSMutableArray *allAssetTypes;
  NSManagedObjectContext *_context;
  NSManagedObjectModel *_model;
}

+ (BNRItemStore *)sharedStore;

- (BNRItem *)createItem;

- (void)removeItem:(BNRItem *)item;

- (void)moveItemAtIndex:(int)from toIndex:(int)to;

- (NSString *)itemArchivePath;

- (BOOL)saveChanges;

- (NSArray *)allItems;

- (NSArray *)allAssetTypes;

@end