//
//  ViewController.m
//  CustomSlider
//
//  Created by mac on 17/3/21.
//  Copyright © 2017年 _. All rights reserved.
//

#import "ViewController.h"
#import "COXCustomSlider.h"
@interface ViewController ()

@end

#define IPHONE_WIDTH   [UIScreen mainScreen].bounds.size.width
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    COXCustomSlider *slider = [[COXCustomSlider alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 50) unSlidableIndex:5 forbiddenDirection:DIRECTION_LEFT numbersOfSegments:10 unit:@"小时"];
    slider.center = self.view.center;
    slider.backgroundColor = [UIColor whiteColor];
    slider.block = ^(NSInteger index){
        NSLog(@"当前段数---->%ld",index);
    };
    [self.view addSubview:slider];
}

@end
