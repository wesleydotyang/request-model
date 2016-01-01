//
//  JOResponseBody.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOResponseBody.h"

@implementation JOResponseBody

+(JOResponseBody*)responseBodyWithName:(NSString*)requestName value:(JOValue*)value
{
    JOResponseBody *body = [[JOResponseBody alloc] init];
    body.requestName = requestName;
    body.value = value;
    
    return  [body autorelease];
}


-(void)dealloc
{
    self.value = nil;
    self.requestName = nil;
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"[BODY]%@:%@",self.requestName,self.value];
}



@end
