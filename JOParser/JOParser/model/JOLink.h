//
//  JOLink.h
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JOAssignmentExp.h"

@interface JOLink : JOBase

@property (nonatomic,retain) NSString *requestName;
@property (nonatomic,retain) JOAssignmentExp *assignmentExp;


+(JOLink*)linkWithName:(NSString*)requestName assignment:(JOAssignmentExp*)assignment;

@end
