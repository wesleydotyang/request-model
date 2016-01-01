//
//  NSMutableDictionary+duplicate.m
//  testBison
//
//  Created by 4205fy on 13-3-23.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import "NSMutableDictionary+duplicate.h"

@implementation NSMutableDictionary (duplicate)

-(NSMutableDictionary*)ff_addObject:(id)obj forKey:(id<NSCopying>)key
{
    id value = [self objectForKey:key];
    if(value){
        if([value isKindOfClass:[NSMutableArray class]]){
            [value addObject:obj];
        }else{
            NSMutableArray *array = [NSMutableArray arrayWithObjects:value,obj, nil];
            [self setObject:array forKey:key];
        }
    }else{
//        NSMutableArray *array = [NSMutableArray arrayWithObject:obj];
        [self setObject:obj forKey:key];
    }
    return self;
//    [NSMutableDictionary dictionaryWithObject:[NSString stringWithUTF8String:he] forKey:@"IDENTIFIER"];
//    [NSMutableDictionary dictionaryWithObjectsAndKeys:, nil
}

@end
