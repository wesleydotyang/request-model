//
//  JORequest.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JORequest.h"

@implementation JORequest

+(JORequest*)requestWithHeads:(NSArray*)heads body:(JORequestBody*)body
{
    JORequest *request = [[JORequest alloc] init];
    request.headers = heads;
    request.body = body;
    
    return [request autorelease];
}

-(void)dealloc
{
    self.headers = nil;
    self.body = nil;
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@||\n%@",self.headers,self.body];
}

@end
