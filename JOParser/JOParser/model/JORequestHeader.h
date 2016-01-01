//
//  JORequestHeader.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"


typedef enum{
    JOREQUEST_HEADER_NAME,
    JOREQUEST_HEADER_URL,
    JOREQUEST_HEADER_HEADER,
    JOREQUEST_HEADER_POST,
    JOREQUEST_HEADER_GET
}JORequestHeaderType;

@interface JORequestHeader : JOBase

@property (nonatomic,assign) JORequestHeaderType type;

@property (nonatomic,retain) id value;

+(JORequestHeader*)requestHeaderWithType:(JORequestHeaderType)type value:(id)value;

@end
