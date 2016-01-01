//
//  JOProperty.m
//  JOParser
//
//  Created by WesleyYang on 13-7-24.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOProperty.h"

@implementation JOProperty

-(id)init
{
    if (self = [super init]) {
        self.attributes = [NSMutableArray array];
    }
    return self;
}


-(void)addAttribute:(NSString *)attr
{
    [self.attributes addObject:attr];
}


-(void)addServerName:(NSString *)serverName
{
    if (serverName == nil || serverName.length==0) {
        return;
    }
    
    if (_serverNames == nil) {
        _serverNames = [[NSMutableArray alloc] init];
    }

    if([_serverNames containsObject:serverName]){
        return;
    }

    [_serverNames addObject:serverName];
}


-(void)dealloc
{
    self.subType = nil;
    self.attributes = nil;
    self.type = nil;
    self.name = nil;
    self.serverNames = nil;
    [super dealloc];
}

@end
