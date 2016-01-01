//
//  JOService.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JORequest.h"
#import "JOResponse.h"

@interface JOService : JOBase

@property (nonatomic,retain) JORequest *request;
@property (nonatomic,retain) JOResponse *response;


+(JOService*)serviceWithRequest:(JORequest*)request response:(JOResponse*)response;

@end
