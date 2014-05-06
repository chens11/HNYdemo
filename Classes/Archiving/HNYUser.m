//
//  HNYUser.m
//  Demo
//
//  Created by chenzq on 5/6/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYUser.h"

@implementation HNYUser
@synthesize name;
@synthesize phone;
@synthesize address;

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:phone forKey:@"phone"];
    [aCoder encodeObject:address forKey:@"address"];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        name =  [aDecoder decodeObjectForKey:@"name"];
        phone =  [aDecoder decodeObjectForKey:@"phone"];
        address =  [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

#pragma mark -
#pragma mark NSCopying
- (id) copyWithZone:(NSZone *)zone {
    HNYUser *copy = [[[self class] allocWithZone: zone] init];
    copy.name = [self.name copyWithZone: zone];
    copy.phone = [self.phone copyWithZone: zone];
    copy.address = [self.address copyWithZone: zone];
    return copy;
}
@end
