//
//  DetailViewController.h
//  Homepwner
//
//  Created by Ryan Blunden on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UIImagePickerControllerDelegate, UITextFieldDelegate,
    UINavigationControllerDelegate, UIPopoverControllerDelegate>

@property(nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (id)initForViewItem:(BOOL)isNew;

@end