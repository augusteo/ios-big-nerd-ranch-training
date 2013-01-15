//
//  DetailViewController.m
//  Homepwner
//
//  Created by Ryan Blunden on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"

@interface DetailViewController ()

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *serialField;
@property(weak, nonatomic) IBOutlet UITextField *valueField;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailViewController

- (void)setItem:(BNRItem *)item {
  _item = item;
  [[self navigationItem] setTitle:[[self item] itemName]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  BNRItem *item = [self item];
  [[self nameField] setText:[item itemName]];
  [[self serialField] setText:[item serialNumber]];
  [[self valueField] setText:[NSString stringWithFormat:@"%d", [item valueInDollars]]];

  // Create a NSDateFormatter that will turn a date into a simple date string
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  [dateFormatter setTimeStyle:NSDateFormatterNoStyle];

  // Use filtered NSDate object to set dateLabel contents
  [[self dateLabel] setText:[dateFormatter stringFromDate:[item dateCreated]]];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillAppear:animated];

  // Clear the first responder
  [[self view] endEditing:YES];

  // Save changes to item
  BNRItem *item = [self item];
  [item setItemName:[[self nameField] text]];
  [item setSerialNumber:[[self serialField] text]];
  [item setValueInDollars:[[[self valueField] text] intValue]];
}
@end