//
// Created by rblunden on 1/15/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BNRImageStore : NSObject

+ (BNRImageStore *)sharedStore;

- (void)setImage:(UIImage *)i forKey:(NSString *)s;

- (UIImage *)imageForKey:(NSString *)key;

- (void)removeImageForKey:(NSString *)key;

@end