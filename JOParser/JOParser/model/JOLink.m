//
//  JOLink.m
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOLink.h"

@implementation JOLink

+(JOLink*)linkWithName:(NSString*)requestName assignment:(JOAssignmentExp*)assignment{
    
    JOLink *link = [[JOLink alloc] init];
    
    NSString *nameStr = requestName;
    if ([requestName hasPrefix:@"\""]) {
        if (requestName.length<3) {
            NSLog(@"ERROR: request name has a length below 3,ignored!");
            return nil;
        }
        nameStr = [nameStr substringWithRange:NSMakeRange(1, requestName.length-2)];
    }
    
    link.requestName = nameStr ;
    link.assignmentExp = assignment;
    
    return  [link autorelease];
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@:%@",_requestName,_assignmentExp];
}

@end
