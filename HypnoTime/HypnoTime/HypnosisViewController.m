//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HypnosisViewController.h"
#import "HypnosisView.h"

@implementation HypnosisViewController {

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {
    // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
    [tbi setTitle:@"Hypnosis"];

    // Create a UIImage from a file
    // This will use Hypno@2x.png on retina displace devices
    [tbi setImage:[UIImage imageNamed:@"Hypno.png"]];
  }

  return self;
}

- (void)loadView {
  // Create a view
  CGRect frame = [[UIScreen mainScreen] bounds];
  HypnosisView *v = [[HypnosisView alloc] initWithFrame:frame];

  // Se it as the "view" of this view controller
  [self setView:v];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  NSLog(@"HyponsisViewController loaded its view");
}

@end