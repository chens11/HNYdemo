//
//  HNYUser.h
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNYUser : NSObject<NSCopying,NSCoding>
{
    NSString *name;
    NSString *phone;
    NSString *address;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *address;

@end
