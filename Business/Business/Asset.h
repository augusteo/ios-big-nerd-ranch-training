//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class Employee;

@interface Asset : NSObject

@property(strong) NSString *label;
@property(weak) Employee *holder;
@property unsigned int resaleValue;

@end