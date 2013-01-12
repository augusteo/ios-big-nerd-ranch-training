//
//  main.m
//  ArrayNameWordChallenge
//
//  Created by Ryan Blunden on 1/12/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

  @autoreleasepool {

    // Read in a file asa huge string (ignoriing the possibility of an error)
    NSString *nameString = [NSString stringWithContentsOfFile:@"/usr/share/dict/propernames" encoding:NSUTF8StringEncoding error:NULL];
    NSString *wordsString = [NSString stringWithContentsOfFile:@"/usr/share/dict/words" encoding:NSUTF8StringEncoding error:NULL];
    
    // Break it into an array of strings
    NSArray *names = [nameString componentsSeparatedByString:@"\n"];
    NSArray *words = [wordsString componentsSeparatedByString:@"\n"];
    
      // Go through the array one string at a time
    for (NSString *n in names) {

      for(NSString *w in words) {
        
        if([n caseInsensitiveCompare:w] == NSOrderedSame) {
          NSLog(@"%@ == %@", n, w);
        }
      }
    }
    
    // This is not a full solution as it's not case insensitive
    for (NSString *n in names) {
      if([words containsObject:n]) {
        NSLog(@"%@ in words", n);
      }
    }
    
    // Using blocks
    for (NSString *n in names) {
      NSUInteger found = [words indexOfObjectPassingTest:^BOOL(id element, NSUInteger idx,BOOL *stop) {
        return [n caseInsensitiveCompare:element] == NSOrderedSame;
       }];
      
      if(found) {
        NSLog(@"%@ found in words at index %lu", n, found);
      }
    }
    
  }
    return 0;
}

