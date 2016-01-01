//
//  JORequest.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JORequestBody.h"
#import "JORequestHeader.h"

@interface JORequest : JOBase

@property (nonatomic,retain) NSArray *headers;
@property (nonatomic,retain) JORequestBody   *body;

+(JORequest*)requestWithHeads:(NSArray*)heads body:(JORequestBody*)body;

@end
