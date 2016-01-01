//
//  JOResponse.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOResponse.h"

@implementation JOResponse

+(JOResponse*)responseWithBody:(JOResponseBody*)body
{
    JOResponse *response = [[JOResponse alloc] init];
    response.body = body;
    
    return [response autorelease];
    
}

-(void)dealloc
{
    self.body = nil;
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"[Response]%@",self.body];
}

@end
