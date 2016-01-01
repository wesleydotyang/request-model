//
//  JOProperty.h
//  JOParser
//
//  Created by WesleyYang on 13-7-24.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JOProperty : NSObject

@property (nonatomic,retain) NSMutableArray *attributes;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSString *subType;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSMutableArray *serverNames;

-(void)addAttribute:(NSString*)attr;

-(void)addServerName:(NSString*)serverName;

@end
