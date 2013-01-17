//
// Created by rblunden on 1/16/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BNRItem;

@interface AssetTypePicker : UITableViewController <UITableViewDelegate>

@property (nonatomic, strong) BNRItem *item;

@end