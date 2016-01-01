//
//  JOModel.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOProperty.h"

@interface JOModel : NSObject

@property (nonatomic,retain) NSMutableArray *headerClasses;

@property (nonatomic,retain) NSString *project;
@property (nonatomic,retain) NSString *modelName;
@property (nonatomic,retain) NSMutableArray* properties;

-(void)addProperty:(JOProperty*)property;

-(void)importClass:(NSString*)className;


@end
