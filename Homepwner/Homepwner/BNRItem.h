//
//  BNRItem.h
//  Homepwner
//
//  Created by Ryan Blunden on 1/16/13.
//  Copyright (c) 2013 Ryan Blunden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BNRItem : NSManagedObject

@property (nonatomic, strong) NSString * itemName;
@property (nonatomic, strong) NSString * serialNumber;
@property (nonatomic) int32_t valueInDollars;
@property (nonatomic) NSTimeInterval dateCreated;
@property (nonatomic, strong) NSString * imageKey;
@property (nonatomic, strong) NSData * thumbnailData;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic) double orderingValue;
@property (nonatomic, strong) NSManagedObject *assetType;

-(void)setThumbnailDataFromImage:(UIImage *)image;
@end
