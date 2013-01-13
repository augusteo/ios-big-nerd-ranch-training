//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Person : NSObject

- (id)init;

- (id)initWithFirstName:(NSString *)fn lastName:(NSString *)ln;

@property NSString *firstName;
@property NSString *lastName;

@end