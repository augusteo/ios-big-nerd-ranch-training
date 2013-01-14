//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


NSMutableData *incomingData;
@interface Logger : NSObject {
}

- (void)sayOuch:(NSTimer *)t;

- (void)zoneChange:(NSNotification *)note;
@end