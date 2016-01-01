//
//  JOResponse.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JOResponseBody.h"

@interface JOResponse : JOBase


@property (nonatomic,retain) JOResponseBody   *body;


+(JOResponse*)responseWithBody:(JOResponseBody*)body;

@end
