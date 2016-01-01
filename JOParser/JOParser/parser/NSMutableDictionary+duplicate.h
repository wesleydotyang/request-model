//
//  NSMutableDictionary+duplicate.h
//  testBison
//
//  Created by 4205fy on 13-3-23.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (duplicate)
-(NSMutableDictionary*)ff_addObject:(id)obj forKey:(id<NSCopying>)key;


@end
