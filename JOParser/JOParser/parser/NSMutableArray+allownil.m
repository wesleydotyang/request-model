//
//  NSMutableArray+allownil.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "NSMutableArray+allownil.h"

@implementation NSMutableArray (allownil)

-(void)addObject_:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end
