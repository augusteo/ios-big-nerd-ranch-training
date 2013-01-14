//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TimeViewController.h"


@implementation TimeViewController {

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    UITabBarItem *tbi = [self tabBarItem];
    [tbi setTitle:@"Time"];
    [tbi setImage:[UIImage imageNamed:@"Time.png"]];
  }

  return self;
}

- (IBAction)showCurrentTime:(id)sender {
  NSDate *now = [NSDate date];

  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setTimeStyle:NSDateFormatterMediumStyle];

  [[self timeLabel] setText:[formatter stringFromDate:now]];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  NSLog(@"TimeViewController loaded its view");
}
@end