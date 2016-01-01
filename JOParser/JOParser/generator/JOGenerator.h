//
//  JOGenerator.h
//  JOParser
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JOGenerator : NSObject

@property (nonatomic,retain) id input;
@property (nonatomic,retain) NSString *outputPath;


+(JOGenerator*)generatorFromInput:(id)input outputPath:(NSString*)path;

-(void)generateOutput;

@end
