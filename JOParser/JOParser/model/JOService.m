//
//  JOService.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOService.h"

@implementation JOService


+(JOService*)serviceWithRequest:(JORequest*)request response:(JOResponse*)response
{
    JOService *service = [[JOService alloc] init];
    service.request = request;
    service.response = response;
    
    return [service autorelease];
}


-(void)dealloc
{
    self.request = nil;
    self.response = nil;
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@\n%@",_request,_response];
}


@end
