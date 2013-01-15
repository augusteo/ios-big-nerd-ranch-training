//
//  DetailViewController.h
//  Homepwner
//
//  Created by Ryan Blunden on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) BNRItem *item;
@end