//
//  JOAssignmentExp.m
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOAssignmentExp.h"

@implementation JOAssignmentExp


+(JOAssignmentExp*)assignmentExpWithDeclareExp:(JODeclareExp*)declare value:(JOValue*)value
{
    
    JOAssignmentExp *assign = [[JOAssignmentExp alloc] init];
    assign.declareExp = declare;
    assign.value = value;
    
    return [assign autorelease];
   
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@=%@",_declareExp,_value];
}

@end
