//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRDrawViewController.h"
#import "BNRDrawView.h"


@implementation BNRDrawViewController {
}

- (void)loadView {
  [self setView:[[BNRDrawView alloc] initWithFrame:CGRectZero]];
}
@end