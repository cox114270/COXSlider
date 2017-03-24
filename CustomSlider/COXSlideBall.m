//
//  COXSlideBall.m
//  CustomSlider
//
//  Created by mac on 17/3/22.
//  Copyright © 2017年 _. All rights reserved.
//

#import "COXSlideBall.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation COXSlideBall
{
    CGFloat  _radius;
    UIColor *_backgroundColor;
}

- (instancetype)initWithRadius:(CGFloat)radius color:(UIColor *)color {
    if (self = [super init]) {
        _radius = radius;
        _backgroundColor = color;
        self.backgroundColor = [UIColor clearColor];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, rect.size.width, rect.size.width)];
    [_backgroundColor setFill];
    [path fill];
}

@end
