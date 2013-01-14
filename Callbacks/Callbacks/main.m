//
//  main.m
//  Callbacks
//
//  Created by Ryan Blunden on 01/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"

int main(int argc, const char *argv[]) {

  @autoreleasepool {
    Logger *logger = [[Logger alloc] init];

    // Helper objects - Here is a helper object that conforms to a protocol
    NSURL *url = [NSURL URLWithString:@"http://www.gutenberg.org/cache/epub/205/pg205.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request
                                                                          delegate:logger
                                                                  startImmediately:YES];

    // Notifications using default notification center
    [[NSNotificationCenter defaultCenter] addObserver:logger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];

    // Target-action - When something happens, send this message to this object
    __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                               target:logger
                                                             selector:@selector(helloChap:)
                                                             userInfo:nil
                                                              repeats:YES];
    [[NSRunLoop currentRunLoop] run];
  }

  return 0;
}
