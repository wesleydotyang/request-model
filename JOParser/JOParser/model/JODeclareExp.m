//
//  JODeclareExp.m
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JODeclareExp.h"

@implementation JODeclareExp


+(JODeclareExp*)declareExpWithType:(JOTypeSpecifier*)type varName:(NSString*)name
{
    JODeclareExp *declare = [[JODeclareExp alloc] init];
    declare.type = type;
    declare.varName = name;
    
    return [declare autorelease];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@",_type,_varName];
}

@end
