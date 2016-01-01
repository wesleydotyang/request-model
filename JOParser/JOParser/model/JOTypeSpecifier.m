//
//  JOTypeSpecifier.m
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOTypeSpecifier.h"

@implementation JOTypeSpecifier


+(JOTypeSpecifier *)typeWithName:(NSString *)name subName:(NSString *)subname
{
    JOTypeSpecifier *type = [[JOTypeSpecifier alloc] init];
    type.typeName = name;
    type.subtypeName = subname;
    
    return  [type autorelease];
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"[T]%@(%@)",_typeName,_subtypeName];
}

-(void)dealloc
{
    self.typeName = nil;
    self.subtypeName = nil;
    [super dealloc];
}

@end
