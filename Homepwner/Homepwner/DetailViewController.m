//
//  DetailViewController.m
//  Homepwner
//
//  Created by Ryan Blunden on 01/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface DetailViewController ()

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *serialField;
@property(weak, nonatomic) IBOutlet UITextField *valueField;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(weak, nonatomic) IBOutlet UIToolbar *toolbarView;
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deletePictureButton;

- (IBAction)backgroundTapped:(id)sender;

- (IBAction)takePicture:(id)sender;

- (IBAction)deletePicture:(id)sender;

@end

@implementation DetailViewController

- (id)init {
  self = [super init];
  if (self) {
    // Create a new bar button item that will send done to DetailViewController
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                         target:self action:@selector(finishEditing)];
    [[self navigationItem] setRightBarButtonItem:bbi];
  }

  return self;
}

- (void)setItem:(BNRItem *)item {
  _item = item;
  [[self navigationItem] setTitle:[[self item] itemName]];
}

- (IBAction)deletePicture:(id)sender {
  [[BNRImageStore sharedStore] removeImageForKey:[[self item] imageKey]];
  [[self item] setImageKey:nil];
  [[self imageView] setImage:nil];
  [[self deletePictureButton] setHidden:TRUE];
}

- (IBAction)backgroundTapped:(id)sender {
  [[self view] endEditing:YES];
}

- (void)viewWasSingleFingerTapped {
  //[self findAndResignFirstResponder];
  [[self view] endEditing:YES];

}

- (void)viewDidLoad {
  [super viewDidLoad];
  // The other way to achieve this is to have the view be a type of class UIControl
  // That way, it can send the message "backgroundTapped" to its delegate
  //
  //UIGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
  //                                                                               action:@selector
  //                                                                               (viewWasSingleFingerTapped)];
  //[[self view] addGestureRecognizer:singleFingerTap];
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

  NSString *imageKey = [[self item] imageKey];

  if (imageKey) {
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    [[self imageView] setImage:imageToDisplay];
  }
  else {
    [[self imageView] setImage:nil];
    [[self deletePictureButton] setHidden:YES];
  }
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self saveItem];
}

- (void)saveItem {
  // Save changes to item
  BNRItem *item = [self item];
  [item setItemName:[[self nameField] text]];
  [item setSerialNumber:[[self serialField] text]];
  [item setValueInDollars:[[[self valueField] text] intValue]];
}

- (void)finishEditing {
  [self saveItem];
  [[self view] endEditing:YES];
  [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (BOOL)findAndResignFirstResponder {
  if (self.view.isFirstResponder) {
    [self resignFirstResponder];
    return YES;
  }
  for (UIView *subView in [[self view] subviews]) {
    if ([subView resignFirstResponder])
      return YES;
  }
  return NO;
}

- (IBAction)takePicture:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

  // If our devices has a camera, we want to take a picture, otherwise, we just pick from the photo library
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
  }
  else {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  }

  [imagePicker setDelegate:self];

  // place image picker on the screen
  [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  NSString *oldKey = [[self item] imageKey];
  if (oldKey) {
    [[BNRImageStore sharedStore] removeImageForKey:oldKey];
  }

  // Get picked image from info dictionary
  UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

  // Create a NSUUID object - and get its string representation
  NSUUID *uuid = [[NSUUID alloc] init];
  NSString *key = [uuid UUIDString];

  [[self item] setImageKey:key];

  // Store the image in the BNRImagetore for this key
  [[BNRImageStore sharedStore] setImage:image forKey:key];

  // Put that image onto the screen in our image view
  [[self deletePictureButton] setHidden:NO];
  [[self imageView] setImage:image];

  // Take image picker off the screen - you must call this dismiss method
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}
@end