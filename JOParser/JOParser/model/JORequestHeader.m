//
//  JORequestHeader.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JORequestHeader.h"

@implementation JORequestHeader

+(JORequestHeader *)requestHeaderWithType:(JORequestHeaderType)type value:(id)value
{
    JORequestHeader *header = [[JORequestHeader alloc] init];
    
    header.type = type;
    header.value = value;
    
    return [header autorelease];
    
}

-(void)dealloc
{
    self.value =nil;
    [super dealloc];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"[HEAD%d]%@",self.type,self.value];
}

@end
