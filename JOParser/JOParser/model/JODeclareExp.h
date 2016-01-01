//
//  JODeclareExp.h
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOBase.h"
#import "JOTypeSpecifier.h"

@interface JODeclareExp : JOBase

@property (nonatomic,retain) NSString *varName;

@property (nonatomic,retain) JOTypeSpecifier *type;


+(JODeclareExp*)declareExpWithType:(JOTypeSpecifier*)type varName:(NSString*)name;

@end
