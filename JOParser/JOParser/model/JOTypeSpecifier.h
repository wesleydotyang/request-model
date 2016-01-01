//
//  JOTypeSpecifier.h
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"

@interface JOTypeSpecifier : JOBase

@property (nonatomic,retain) NSString *typeName;

@property (nonatomic,retain) NSString *subtypeName;


+(JOTypeSpecifier*)typeWithName:(NSString*)name subName:(NSString*)subname;

@end
