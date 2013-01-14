//
// Created by rblunden on 1/13/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Logger.h"


@implementation Logger

- (void)helloChap:(NSTimer *)t {
  NSLog(@"Hello chap.");
}

// Called each time a chunk of data arrives
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  NSLog(@"Received %lu bytes", [data length]);

  // Create a mutable data if it doesn't already exist
  if (!incomingData) {
    incomingData = [[NSMutableData alloc] init];
  }

  [incomingData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSLog(@"Got it all");

  NSString *string = [[NSString alloc] initWithData:incomingData encoding:NSUTF8StringEncoding];
  incomingData = nil;
  NSLog(@"string has %lu characters", [string length]);

  // Uncomment next line to see file contents
  NSLog(@"The whole string is %@", string);
}

- (void)zoneChange:(NSNotification *)note {
  NSLog(@"The system time zone has changed");
}
@end