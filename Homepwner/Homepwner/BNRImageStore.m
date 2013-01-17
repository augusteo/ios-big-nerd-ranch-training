//
// Created by rblunden on 1/15/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRImageStore.h"

@interface BNRImageStore () {
  NSMutableDictionary *_dictionary;
}

- (NSString *)imagePathForKey:(NSString *)key;

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

  // Create full path for image
  NSString *imagePath = [self imagePathForKey:key];

  // Turn image into JPEG data
  NSData *d = UIImageJPEGRepresentation(i, 0.8);

  // Write it to full path
  [d writeToFile:imagePath atomically:YES];

}

- (UIImage *)imageForKey:(NSString *)key {

  // If possible, get it from the dictionary
  UIImage *result = [_dictionary objectForKey:key];

  if (!result) {
    // Create UIImage object fro file
    result = [UIImage imageWithContentsOfFile:[self imagePathForKey:key]];

    // If we found an image on the file system, place it into the cache
    if (result) {
      [_dictionary setObject:result forKey:key];
    }
    else {
      NSLog(@"Error: unable to find %@", key);
    }
  }

  return result;
}

- (void)removeImageForKey:(NSString *)key {
  if (!key) {
    return;
  }

  [_dictionary removeObjectForKey:key];

  NSString *path = [self imagePathForKey:key];
  [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key {
  NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

  NSString *documentdirectory = [documentDirectories objectAtIndex:0];

  return [documentdirectory stringByAppendingPathComponent:key];
}

@end