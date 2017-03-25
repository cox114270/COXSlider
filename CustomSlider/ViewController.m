//
//  ViewController.m
//  CustomSlider
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 _. All rights reserved.
//

#import "ViewController.h"
#import "CoxSegmentSlider.h"
@interface ViewController ()

@end

#define IPHONE_WIDTH   [UIScreen mainScreen].bounds.size.width
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CoxSegmentSlider *slider = [[CoxSegmentSlider alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) / 2, CGRectGetWidth(self.view.frame), 50) sectionsCount:10 minIndex:0 maxIndex:10 stopIndex:5 stopDirection:STOP_DIRECTION_TYPE_LEFT showUnit:@"元"];
    [self.view addSubview:slider];
}

@end
