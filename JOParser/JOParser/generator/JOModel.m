//
//  JOModel.m
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOModel.h"

@implementation JOModel


-(id)init
{
    if (self=[super init]) {
        _properties = [[NSMutableArray array] retain];
        _headerClasses = [[NSMutableArray array] retain];
    }
    return self;
}

-(void)addProperty:(JOProperty *)property
{
    if (property == nil) {
        return;
    }
    
    for (JOProperty *p in _properties) {
        if ([p.name isEqualToString:property.name]) {
            //same property
            return;
        }
    }

    [_properties addObject:property];
}

-(void)importClass:(NSString *)className
{
    [self.headerClasses addObject:className];
}




@end
