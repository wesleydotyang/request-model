//
//  JOValue.m
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOValue.h"

@implementation JOValue



+(JOValue*)valueWithType:(JOValueType)type value:(id)value
{
    JOValue *v = [[JOValue alloc] init];
    v.value = value;
    v.valueType = type;
    return [v autorelease];
}
+(JOValue*) valueWithBOOL:(BOOL)val
{
    return [JOValue valueWithType:JOVALUE_TYPE_BOOL value:[NSNumber numberWithBool:val]];
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"(%d)%@",_valueType,_value];
}


-(void)dealloc
{
    
    [super dealloc];
}

@end
