//
// Created by rblunden on 1/17/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () {
  NSMutableDictionary *_linesInProgress;
  NSMutableArray *_finishedLines;
}

- (NSString *)itemArchivePath;

@end

@implementation BNRDrawView {
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];

  if (self) {
    _linesInProgress = [[NSMutableDictionary alloc] init];

    NSString *path = [self itemArchivePath];
    _finishedLines = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!_finishedLines) {
      _finishedLines = [[NSMutableArray alloc] init];
    }

    [self setBackgroundColor:[UIColor grayColor]];
    [self setMultipleTouchEnabled:YES];
  }

  return self;
}

- (NSString *)itemArchivePath {
  NSArray *documentDirectories =
      NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
          NSUserDomainMask, YES);

  // Get one and only document directory from that list
  NSString *documentDirectory = [documentDirectories objectAtIndex:0];

  return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

- (void)drawRect:(CGRect)rect {
  // Create a block that will configure and draw a BNRLine
  void (^strokeLine)(BNRLine *) = ^(BNRLine *line) {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    [bp moveToPoint:[line begin]];
    [bp addLineToPoint:[line end]];
    [bp setLineWidth:10];
    [bp setLineCapStyle:kCGLineCapRound];

    [bp stroke];
  };

  // Draw finished lines in black
  [[UIColor blackColor] set];
  for (BNRLine *line in _finishedLines) {
    strokeLine(line);
  }

  [[UIColor redColor] set];
  for (NSValue *key in _linesInProgress) {
    strokeLine([_linesInProgress objectForKey:key]);
  }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  // Lets put in a log statement to see the order of events
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *t in touches) {
    CGPoint location = [t locationInView:self];
    BNRLine *line = [[BNRLine alloc] init];
    [line setBegin:location];
    [line setEnd:location];

    NSValue *key = [NSValue valueWithNonretainedObject:t];

    [_linesInProgress setObject:line forKey:key];
  }

  [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  // Let's put in a log statement to see the order of events
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *t in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:t];
    BNRLine *line = [_linesInProgress objectForKey:key];

    [line setEnd:[t locationInView:self]];
  }

  [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  // Let's put in a log statement to see the order of events
  NSLog(@"%@", NSStringFromSelector(_cmd));

  for (UITouch *t in touches) {
    NSValue *key = [NSValue valueWithNonretainedObject:t];
    BNRLine *line = [_linesInProgress objectForKey:key];

    [_finishedLines addObject:line];
    [_linesInProgress removeObjectForKey:key];
  }

  [self setNeedsDisplay];

  [self saveChanges];
}

- (BOOL)saveChanges {
  NSString *path = [self itemArchivePath];
  return [NSKeyedArchiver archiveRootObject:_finishedLines toFile:path];
}
@end