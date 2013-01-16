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

@interface DetailViewController () {
  UIPopoverController *_imagePickerPopover;
}

@property(weak, nonatomic) IBOutlet UITextField *nameField;
@property(weak, nonatomic) IBOutlet UITextField *serialField;
@property(weak, nonatomic) IBOutlet UITextField *valueField;
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(weak, nonatomic) IBOutlet UIToolbar *toolbarView;
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(weak, nonatomic) IBOutlet UIButton *deletePictureButton;

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
  //[[self deletePictureButton] setHidden:TRUE];
}

- (IBAction)backgroundTapped:(id)sender {
  [[self view] endEditing:YES];
  [[self nameField] exerciseAmbiguityInLayout];
}

- (void)viewWasSingleFingerTapped {
  //[self findAndResignFirstResponder];
  [[self view] endEditing:YES];

}

- (void)viewDidLoad {
  [super viewDidLoad];

  UIImageView *iv = [[UIImageView alloc] initWithImage:nil];

  // The contentMode of the image view in the XIB was Aspect Fit:
  [iv setContentMode:UIViewContentModeScaleAspectFit];

  [iv setTranslatesAutoresizingMaskIntoConstraints:NO];

  // The image view was a subview of the view
  [[self view] addSubview:iv];

  // The image view was pointed to by the _imageView instance variable
  [self setImageView:iv];

  NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:[self imageView]
                                                                   attribute:NSLayoutAttributeTop
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:[self dateLabel]
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1.0
                                                                    constant:0.0];

  [[self view] addConstraint:topConstraint];

  NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:[self imageView]
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:[self view]
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1
                                                                     constant:0];
  [[self view] addConstraint:leftConstraint];

  NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:[self imageView]
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:[self view]
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1
                                                                      constant:0];
  [[self view] addConstraint:rightConstraint];

  NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:[self imageView]
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:[self toolbarView]
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:0];
  [[self view] addConstraint:bottomConstraint];
}

- (void)viewDidLayoutSubviews {
  for (UIView *v in [[self view] subviews]) {
    if ([v hasAmbiguousLayout]) {
      NSLog(@"AMIGUOUS: %@", v);
    }
  }
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
//    [[self deletePictureButton] setHidden:YES];
  }
  else {
    [[self imageView] setImage:nil];
//    [[self deletePictureButton] setHidden:YES];
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

  if ([_imagePickerPopover isPopoverVisible]) {
    // If the popover is already up, get rid of it
    [_imagePickerPopover dismissPopoverAnimated:YES];
    _imagePickerPopover = nil;
    return;
  }

  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

  // Place image picker on the screen
  // Check for iPad device before instantiating the popover controller
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    // Create a new popover controller that will display the imagePicker
    _imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    [_imagePickerPopover setDelegate:self];

    // Display the popover controller; sender is the camera bar button item
    [_imagePickerPopover presentPopoverFromBarButtonItem:sender
                                permittedArrowDirections:UIPopoverArrowDirectionAny
                                                animated:YES];
  }
  else {
    [self presentViewController:imagePicker animated:YES completion:nil];
  }

  // If our devices has a camera, we want to take a picture, otherwise, we just pick from the photo library
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
  }
  else {
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  }

  [imagePicker setDelegate:self];
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
//  [[self deletePictureButton] setHidden:NO];
  [[self imageView] setImage:image];

  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    // On phone, image picker is presented modally. Dismiss it
    [self dismissViewControllerAnimated:YES completion:nil];
  }
  else {
    [_imagePickerPopover dismissPopoverAnimated:YES];
    _imagePickerPopover = nil;
  }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  NSLog(@"User dismissed popover");
  _imagePickerPopover = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}
@end