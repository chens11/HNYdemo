//
//  HNYGetIPUtils.h
//  Demo
//
//  Created by chenzq on 7/16/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#import <dlfcn.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface HNYGetIPUtils : NSObject
+ (NSString *)getMacAddress;
+ (NSString *)getLocalWiFiIPAddress;

@end
