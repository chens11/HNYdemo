//
//  HNYJSONUitls.h
//  Demo
//
//  Created by chenzq on 5/13/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNYJSONUitls : NSObject

+ (id)mappingDictionary:(NSDictionary*)dictionary toObjectWithClassName:(NSString*)className;
+ (void)mappingDictionary:(NSDictionary*)dictionary toObject:(id)object;
+ (NSDictionary*)getDictionaryFromObject:(id)object;
@end
