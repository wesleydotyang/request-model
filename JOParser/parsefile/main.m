//
//  main.m
//  parsefile
//
//  Created by WesleyYang on 13-7-23.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicParser.h"
#import "GRMustache.h"
#import "JOGenerator.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        const char *usage = "usage: -output paraFolderName \n\t -input paraInputFileName\n";
        if(argc==1){
            printf("%s",usage);
            exit(1);
        }
        NSString *inputFilePath = nil;
        NSString *outputPath = nil;
        for (int i=0; i<argc; ++i) {
            if (i==0) {
                outputPath = [NSString stringWithCString:argv[0] encoding:NSUTF8StringEncoding];
            }
            printf("[arg]%s\n",argv[i]);
            
            if (strcmp(argv[i],"-output")==0) {
                if (i+1<argc) {
                    outputPath = [NSString stringWithCString:argv[i+1] encoding:NSUTF8StringEncoding];
                }
            }
            if (strcmp(argv[i],"-input")==0) {
                if (i+1<argc) {
                    inputFilePath = [NSString stringWithCString:argv[i+1] encoding:NSUTF8StringEncoding];
                }
            }
        }
        
        if (inputFilePath==nil || outputPath==nil || inputFilePath.length==0 || outputPath.length == 0) {
            printf("%s",usage);
            exit(1);
        }
        
        NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
        BOOL isDir;
        BOOL exists = [fm fileExistsAtPath:outputPath isDirectory:&isDir];
        if (exists && !isDir) {
            printf("Output path is not a directory");
            exit(2);
        }
        if (!exists) {
            printf("Output path doesn't exist,create automaticlly.");
        }
        
        exists = [fm fileExistsAtPath:inputFilePath isDirectory:&isDir];
        if (!exists) {
            printf("Input file doesn't exist");
            exit(2);
        }
        if (isDir) {
            printf("Input path  is not a file!");
            exit(2);
        }
        
        // insert code here...
        NSLog(@"OutPutTo:%@",outputPath);
        NSString *input = [NSString stringWithContentsOfFile:inputFilePath encoding:NSUTF8StringEncoding error:nil];
//        NSString *input = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        
        input = [input stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
        input = [input stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
        input = [input stringByReplacingOccurrencesOfString:@"。" withString:@"."];
        input = [input stringByReplacingOccurrencesOfString:@"，" withString:@","];
        input = [input stringByReplacingOccurrencesOfString:@"：" withString:@":"];
        input = [input stringByReplacingOccurrencesOfString:@"（" withString:@"("];
        input = [input stringByReplacingOccurrencesOfString:@"）" withString:@")"];
        input = [input stringByReplacingOccurrencesOfString:@"【" withString:@"["];
        input = [input stringByReplacingOccurrencesOfString:@"】" withString:@"]"];
        input = [input stringByReplacingOccurrencesOfString:@"‘" withString:@"'"];
//        input = [input stringByReplacingOccurrencesOfString:@"" withString:@"]"];

//        NSLog(@"INPUT:%@",input);
        
        [[PublicParser sharedParser] parseObjectiveCString:input completion:^(NSArray *result, NSString *logInfo, NSString *logError) {
            
//            NSLog(@"COMPLETE\n%@",result[0]);
            
            JOGenerator *gen = [JOGenerator generatorFromInput:result outputPath:outputPath];
            [gen generateOutput];
        }];
        
        
//        NSString *modelHeaderTemplatePath = [[NSBundle mainBundle] pathForResource:@"ModelTemplate" ofType:@"h"];
//        GRMustacheTemplate *template = [GRMustacheTemplate templateFromContentsOfFile:modelHeaderTemplatePath error:nil];
//        
//        NSDictionary *obj = @{@"class_name":@"Hello"};
//        NSLog(@"input obj:%@",obj);
//        NSString * result = [template renderObject:obj  error:nil];
//        NSLog(@"result:%@",result);
        
    }
    return 0;
}


