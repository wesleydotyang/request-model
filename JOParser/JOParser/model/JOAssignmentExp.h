//
//  JOAssignmentExp.h
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JODeclareExp.h"
#import "JOValue.h"

@interface JOAssignmentExp : JOBase

@property (nonatomic,retain) JODeclareExp   *declareExp;
@property (nonatomic,retain) JOValue        *value;


+(JOAssignmentExp*)assignmentExpWithDeclareExp:(JODeclareExp*)declare value:(JOValue*)value;

@end
