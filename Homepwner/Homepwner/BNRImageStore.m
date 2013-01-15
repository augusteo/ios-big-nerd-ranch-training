//
// Created by rblunden on 1/15/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRImageStore.h"

@interface BNRImageStore () {
  NSMutableDictionary *_dictionary;
}

@end

@implementation BNRImageStore

+ (id)allocWithZone:(NSZone *)zone {
  return [self sharedStore];
}

+ (BNRImageStore *)sharedStore {
  static BNRImageStore *sharedStore = nil;
  if (!sharedStore) {
    // Create the singleton
    sharedStore = [[super allocWithZone:NULL] init];
  }

  return sharedStore;
}

- (id)init {
  self = [super init];
  if (self) {
    _dictionary = [[NSMutableDictionary alloc] init];
  }

  return self;
}

- (void)setImage:(UIImage *)i forKey:(NSString *)key {
  [_dictionary setObject:i forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
  return [_dictionary objectForKey:key];
}

- (void)removeImageForKey:(NSString *)key {
  [_dictionary removeObjectForKey:key];
}
@end