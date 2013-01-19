//
// Created by rblunden on 1/18/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "JSONSerializable.h"


@interface BNRConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
  NSURLConnection *internalConnection;
  NSMutableData *container;
}

- (id)initWithRequest:(NSURLRequest *)request;

@property(nonatomic, copy) NSURLRequest *request;
@property(nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property(nonatomic, strong) id <NSXMLParserDelegate> xmlRootObject;
@property(nonatomic, strong) id <JSONSerializable> jsonRootObject;

- (void)start;

@end