//
//  TimeViewController.m
//  HypnoTime
//
//  Created by joeconway on 8/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

- (void)spinTimeLabel;

- (void)bounceTimeLabel;
@end

@implementation TimeViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
  // Call the superclass's designated initializer
  // Get a pointer to the application bundle object
  NSBundle *appBundle = [NSBundle mainBundle];

  self = [super initWithNibName:@"TimeViewController"
                         bundle:appBundle];

  if (self) {
    // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    // Give it a label
    [tbi setTitle:@"Time"];

    UIImage *i = [UIImage imageNamed:@"Time.png"];
    [tbi setImage:i];


  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  NSLog(@"CurrentTimeViewController will appear");
  [super viewWillAppear:animated];
  [self showCurrentTime:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  NSLog(@"CurrentTimeViewController will DISappear");
  [super viewWillDisappear:animated];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  NSLog(@"Unloading TimeViewController's subviews %@", timeLabel);
//    timeLabel = nil;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"TimeViewController loaded its view.");
  [[self view] setBackgroundColor:[UIColor greenColor]];
}

- (IBAction)showCurrentTime:(id)sender {
  NSDate *now = [NSDate date];
  // Static here means "only once." The variable formatter
  // is created when the program is first loaded into memory.
  // The first time this method runs, formatter will
  // be nil and the if-block will execute, creating
  // an NSDateFormatter object that formatter will point to.
  // Subsequent entry into this method will reuse the same
  // NSDateFormatter object.
  static NSDateFormatter *formatter = nil;
  if (!formatter) {
    formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
  }
  [timeLabel setText:[formatter stringFromDate:now]];

  [self bounceTimeLabel];
}

- (void)spinTimeLabel {
  // Create a basic animation
  CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];

  [spin setDelegate:self];

  // romValue is implied
  [spin setToValue:@(M_PI * 2.0)];
  [spin setDuration:1.0];

  // Set the timing function
  CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  [spin setTimingFunction:tf];

  // Kick off the animation by adding it to the layer
  [[timeLabel layer] addAnimation:spin forKey:@"spinAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  NSLog(@"%@ finished %d", anim, flag);
}

- (void)bounceTimeLabel {
  // Bounce animation
  CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
  CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1);
  CATransform3D back = CATransform3DMakeScale(0.7, 0.7, 1);
  CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
  CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);
  [bounce setValues:@[
      [NSValue valueWithCATransform3D:CATransform3DIdentity],
      [NSValue valueWithCATransform3D:forward],
      [NSValue valueWithCATransform3D:back],
      [NSValue valueWithCATransform3D:forward2],
      [NSValue valueWithCATransform3D:back2],
      [NSValue valueWithCATransform3D:CATransform3DIdentity]
  ]];
  [bounce setDuration:0.6];

  // Opacity animation
  CABasicAnimation *opacity;
  opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
  opacity.duration = 0.3;
  opacity.autoreverses = YES;
  opacity.fromValue = [NSNumber numberWithFloat:1.0];
  opacity.toValue = [NSNumber numberWithFloat:0];

  // Create a group for our animations
  CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
//  [group setAnimations:@[bounce, opacity]];
  [group setAnimations:@[bounce]];


  // Animate the layer
//  [[timeLabel layer] addAnimation:group forKey:@"bounceOpacity"];
  [[timeLabel layer] addAnimation:bounce forKey:@"bounce"];
  [[timeLabel layer] addAnimation:opacity forKey:@"opacity"];
}

@end
