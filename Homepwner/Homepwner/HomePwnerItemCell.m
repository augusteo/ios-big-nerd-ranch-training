//
// Created by rblunden on 1/16/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HomePwnerItemCell.h"

@implementation HomePwnerItemCell

- (void)awakeFromNib {
  for (UIView *v in [[self contentView] subviews]) {
    [v setTranslatesAutoresizingMaskIntoConstraints:NO];
  }

  // Name all of the views for the visual format string
  NSDictionary *names = @{
      @"image" : [self thumbnailView],
      @"name" : [self nameLabel],
      @"value" : [self valueLabel],
      @"serial" : [self serialNumberLabel]
  };

  // Create a horizontal visual format string
  NSString *fmt = @"H:|-2-[image(==40)]-[name]-[value(==42)]-|";

  // Create the constraints from this visual format string
  NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:fmt
                                                                 options:0
                                                                 metrics:nil views:names];

  // Add the constraints to the content view, which is the superview for all of the cell's content
  [[self contentView] addConstraints:constraints];

  fmt = @"V:|-1-[name(==20)]-(>=0)-[serial(==20)]-1-|";
  constraints = [NSLayoutConstraint constraintsWithVisualFormat:fmt
                                                        options:NSLayoutFormatAlignAllLeft
                                                        metrics:nil
                                                          views:names];
  [[self contentView] addConstraints:constraints];

  NSArray * (^constraintBuilder)(UIView *, float);
  constraintBuilder = ^(UIView *view, float height) {
    return @[
        // Constraint 0: Center Y of incoming view to contentView
        [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual toItem:[self contentView]
                                     attribute:NSLayoutAttributeCenterY multiplier:1.0
                                      constant:0.0],

        // Constraint 1 - Pin width of incoming view to constant height
        [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0
                                      constant:height]
    ];
  };

  constraints = constraintBuilder([self thumbnailView] , 40);
  [[self contentView] addConstraints:constraints];

  constraints = constraintBuilder([self valueLabel], 21);
  [[self contentView] addConstraints:constraints];
}

@end