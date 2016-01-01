//
//  JOValue.h
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOBase.h"

typedef enum{
    JOVALUE_TYPE_STRING,
    JOVALUE_TYPE_BOOL,
    JOVALUE_TYPE_INT,
    JOVALUE_TYPE_DOUBLE,
    JOVALUE_TYPE_DICTIONARY,
    JOVALUE_TYPE_ARRAY
}JOValueType;


@interface JOValue : JOBase

@property (nonatomic,retain) id value;

//private
@property (nonatomic,assign) JOValueType valueType;


+(JOValue*)valueWithType:(JOValueType)type value:(id)value;

+(JOValue*) valueWithBOOL:(BOOL)val;

@end
