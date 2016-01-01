//
//  JOViewController.m
//  JOParser
//
//  Created by WesleyYang on 13-7-22.
//  Copyright (c) 2013年 wesley.yang. All rights reserved.
//

#import "JOViewController.h"
#import "PublicParser.h"

@interface JOViewController ()

@end

@implementation JOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *input = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input0" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"INPUT:%@",input);
    
    [[PublicParser sharedParser] parseObjectiveCString:input completion:^(NSArray *result) {
        NSLog(@"COMPLETE\n%@",result[0]);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_label release];
    [super dealloc];
}
@end
