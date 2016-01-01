//
//  testBison
//
//  Created by 4205fy on 13-3-24.
//  Copyright (c) 2013年 4205fy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicParser : NSObject

+(PublicParser*)sharedParser;

-(void)parseObjectiveCString:(NSString *)input completion:(void(^)(NSArray* result,NSString *logInfo,NSString *logError))completionBlock;



@end
