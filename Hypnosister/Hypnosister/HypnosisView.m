//
// Created by rblunden on 1/14/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "HypnosisView.h"


@implementation HypnosisView
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
  }
  return self;
}

- (void)drawRect:(CGRect)dirtyRect {
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGRect bounds = [self bounds];

  // Figure out the center of the bounds rectangle
  CGPoint center;
  center.x = bounds.origin.x + bounds.size.width / 2.0;
  center.y = bounds.origin.y + bounds.size.height / 2.0;

  // The radius of the circle should be nearly as big as the view
  float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

  // The thickness of the line should be 10 points wide
  CGContextSetLineWidth(ctx, 10);

  // The color of the line should be gray (red/ green/ blue = 0.6, alpha = 1.0);
//  CGContextSetRGBStrokeColor(ctx, 0.6, 0.6, 0.6, 1.0);
  [[UIColor lightGrayColor] setStroke];

  // DRaw concentric circles from the outside in
  for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    // Add a path to the context
    CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);

    // Perform drawing instruction; removes path
    CGContextStrokePath(ctx);
  }
}
@end