//
//  HypnosisView.m
//  Hypnosister
//
//  Created by joeconway on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HypnosisView.h"
#import "QuartzCore/QuartzCore.h"

@interface HypnosisView () {
  CALayer *_boxLayer;
}

@end

@implementation HypnosisView
@synthesize circleColor;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setCircleColor:[UIColor lightGrayColor]];

    // Create the new layer object
    _boxLayer = [[CALayer alloc] init];

    // Size
    [_boxLayer setBounds:CGRectMake(0.0, 0.0, 85.0, 85.0)];

    // Location
    [_boxLayer setPosition:CGPointMake(160.0, 100.0)];

    // Make half-transparent red the background color
    UIColor *reddish = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.5];

    // Get a CGClor object with the same color values
    CGColorRef cgReddish = [reddish CGColor];
    [_boxLayer setBackgroundColor:cgReddish];

    // Create a UIImage
    UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"];

    // Get the underlying CGImage
    CGImageRef image = [layerImage CGImage];

    // Put the CGImage on the layer
    [_boxLayer setContents:(__bridge id)image];

    // Inser the image a bit on each side
    [_boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)];

    // Let the image resize (without changing the aspect ratio) to fill the contentRect
    [_boxLayer setContentsGravity:kCAGravityResizeAspect];


    // Make it a sublayer of the view's layer
    [[self layer] addSublayer:_boxLayer];
  }
  return self;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
  if (motion == UIEventSubtypeMotionShake) {
    NSLog(@"Device started shaking!");
    [self setCircleColor:[UIColor redColor]];
  }
}

- (void)setCircleColor:(UIColor *)clr {
  circleColor = clr;
  [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder {
  return YES;
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

  [[self circleColor] setStroke];

  // Draw concentric circles from the outside in
  for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);

    CGContextStrokePath(ctx);
  }

  // Create a string
  NSString *text = @"You are getting sleepy.";

  // Get a font to draw it in
  UIFont *font = [UIFont boldSystemFontOfSize:28];

  CGRect textRect;

  // How big is this string when drawn in this font?
  textRect.size = [text sizeWithFont:font];

  // Let's put that string in the center of the view
  textRect.origin.x = center.x - textRect.size.width / 2.0;
  textRect.origin.y = center.y - textRect.size.height / 2.0;

  // Set the fill color of the current context to black
  [[UIColor blackColor] setFill];

  // The shadow will move 4 points to the right and 3 points down from the text
  CGSize offset = CGSizeMake(4, 3);

  // The shadow will be dark gray in color
  CGColorRef color = [[UIColor darkGrayColor] CGColor];

  // Set the shadow of the context with these parameters,
  // all subsequent drawing will be shadowed
  CGContextSetShadowWithColor(ctx, offset, 2.0, color);

  // Draw the string
  [text drawInRect:textRect
          withFont:font];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *t = [touches anyObject];
  CGPoint p = [t locationInView:self];
  [_boxLayer setPosition:p];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *t = [touches anyObject];
  CGPoint p = [t locationInView:self];
  [CATransaction begin];
  [CATransaction setDisableActions:YES];
  [_boxLayer setPosition:p];
  [CATransaction commit];
}
@end
