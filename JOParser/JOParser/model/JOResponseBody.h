//
//  JOResponseBody.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JOValue.h"


@interface JOResponseBody : JOBase

@property (nonatomic,retain) NSString *requestName;
@property (nonatomic,retain) JOValue *value;


+(JOResponseBody*)responseBodyWithName:(NSString*)requestName value:(JOValue*)value;

@end
