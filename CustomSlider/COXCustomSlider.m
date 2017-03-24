//
//  COXCustomSlider.m
//  CustomSlider
//
//  Created by mac on 17/3/22.
//  Copyright © 2017年 _. All rights reserved.
//

#import "COXCustomSlider.h"
#import "COXSlideBall.h"

@interface COXCustomSlider ()
@property (nonatomic,assign) NSInteger unSlidableIndex;
@property (nonatomic,assign) DIRECTION direction;
@property (nonatomic,assign) NSInteger numbersOfSegments;
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) UILabel *maxLabel;
@end

#define IPHONE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define LineValue (_Vwidth - 40) / _numbersOfSegments * _unSlidableIndex
@implementation COXCustomSlider
{
    COXSlideBall *_ball;
    CGFloat      _currentValue;
    CGFloat      _tureValue;
    CGFloat      _previousX;
    
    CGFloat      _Vheight;
    CGFloat      _Vwidth;
    NSString     *_unit;
}

- (instancetype)initWithFrame:(CGRect)frame unSlidableIndex:(NSInteger)index forbiddenDirection:(DIRECTION)direction numbersOfSegments:(NSInteger)segments unit:(NSString *)unit {
    if (self = [super initWithFrame:frame]) {
        _Vwidth = CGRectGetWidth(frame);
        _Vheight = CGRectGetHeight(frame);
        _direction = direction;
        _unSlidableIndex = index;
        _numbersOfSegments = segments;
        _unit = [unit copy];
        _currentValue = LineValue;
        _previousX = _currentValue + 20;
        _tureValue = 1000;
        _ball = [[COXSlideBall alloc] initWithRadius:15 color:[UIColor redColor]];
        _ball.frame = CGRectMake(0, 0, 30, 30);
        _ball.center = CGPointMake(_previousX,(_Vheight - 10) / 2 + 5);
        [self addSubview:_ball];
        _currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (_Vheight - 10) / 2 + 16, 100, 10)];
        _currentLabel.text = [NSString stringWithFormat:@"%ld%@",index,unit];
        _currentLabel.textColor = [UIColor redColor];
        _currentLabel.font = [UIFont systemFontOfSize:10.0];
        _currentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_currentLabel];
        _maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(_Vwidth - 20 - 100, (_Vheight - 10) / 2 + 16, 100, 10)];
        _maxLabel.text = [NSString stringWithFormat:@"%ld%@",_numbersOfSegments,unit];
        _maxLabel.textColor = [UIColor redColor];
        _maxLabel.font = [UIFont systemFontOfSize:10.0];
        _maxLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_maxLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, (_Vheight - 10) / 2, _currentValue, 10.0) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    [[UIColor redColor] set];
    [path1 fill];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(_currentValue + 20, (_Vheight - 10) / 2, (_Vwidth - 40) - _currentValue, 10.0) byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    [[UIColor redColor] set];
    [path2 stroke];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint point = [touch locationInView:_ball];
    CGPoint Vpoint = [touch locationInView:self];
    CGFloat X = Vpoint.x - (point.x - 15.0);
    
    if (point.x < -20 || point.x > 50 || point.y < -20 || point.y > 50) {
        NSLog(@"超出响应范围");
        return;
    }

    _tureValue = X - 20.0;
    if (X >= 0 ) {
        CGFloat centerX = Vpoint.x;
        if (Vpoint.x > _Vwidth - 20) {
            centerX = _Vwidth - 20;
        }else if (Vpoint.x < 20) {
            centerX = 20.0;
        }
        _currentValue = X - 20;
        _ball.center = CGPointMake(centerX, (_Vheight - 10) / 2 + 5);
        if (_currentValue < 0 ) {
            _currentValue = 0;
        }
        if (_currentValue > _Vwidth - 40) {
            _currentValue = _Vwidth - 40;
        }
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat value = _tureValue / ((_Vwidth - 40) / _numbersOfSegments);
    CGFloat intValue = roundf(value);
    _currentValue = intValue * ((_Vwidth - 40) / _numbersOfSegments);
    if (_direction == DIRECTION_LEFT) {
        if (_tureValue <= LineValue) {
            _ball.center = CGPointMake(LineValue + 20.0, (_Vheight - 10) / 2 + 5);
            _currentValue = LineValue;
            [self setNeedsDisplay];
            _currentLabel.text = [NSString stringWithFormat:@"%ld%@",_unSlidableIndex,_unit];
            _maxLabel.text = [NSString stringWithFormat:@"%ld%@",_numbersOfSegments,_unit];
            return;
        }
    }else{
        if (_tureValue >= LineValue) {
            _ball.center = CGPointMake(LineValue + 20.0, (_Vheight - 10) / 2 + 5);
            _currentValue = LineValue;
            [self setNeedsDisplay];
            _currentLabel.text = [NSString stringWithFormat:@"%ld%@",_unSlidableIndex,_unit];
            _maxLabel.text = [NSString stringWithFormat:@"%ld%@",_numbersOfSegments,_unit];
            return;
        }
    }
    _previousX = _currentValue + 20.0;
    _ball.center = CGPointMake(intValue * ((_Vwidth - 40) / _numbersOfSegments) + 20.0, (_Vheight - 10) / 2 + 5);
    [self setNeedsDisplay];
    _currentLabel.text = [NSString stringWithFormat:@"%d%@",(int)intValue,_unit];
    _maxLabel.text = [NSString stringWithFormat:@"%ld%@",_numbersOfSegments,_unit];
    if (_block) {
        _block(intValue);
    }
}
@end
