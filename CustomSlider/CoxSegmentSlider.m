//
//  CoxSegmentSlider.m
//  CustomSlider
//
//  Created by mac on 17/3/25.
//  Copyright © 2017年 _. All rights reserved.
//

#import "CoxSegmentSlider.h"
#import "UIColor+Hex.h"

#define Color_ff8bda     [UIColor colorWithHex:0xff8dba]
static CGFloat slide_ball_radius = 8.0f;
static CGFloat slide_pole_hight = 7.0;
@implementation CoxSegmentSlider
{
    CGFloat  _sliderBallCenterX;
    CGFloat  _Vwidth;
    CGFloat  _Vheight;
    NSInteger _currentSectionIndex;
    CGFloat   _sliderWidth;
}

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame sectionsCount:(NSUInteger)count minIndex:(CGFloat)min maxIndex:(CGFloat)max stopIndex:(CGFloat)stop stopDirection:(STOP_DIRECTION_TYPE)type showUnit:(NSString *)unit {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _Vwidth = CGRectGetWidth(frame);
        _sliderWidth = _Vwidth - 20;
        _Vheight = CGRectGetHeight(frame);
        _sectionsCount = count;
        _minIndex = min;
        _maxIndex = max;
        _stopIndex = stop;
        _type = type;
        _unit = [unit copy];
        _currentSectionIndex = _stopIndex;
        _sliderBallCenterX = _stopIndex * (_sliderWidth / _sectionsCount) + 10;
        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //圆球
    UIBezierPath *ballPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_sliderBallCenterX , _Vheight / 2.0) radius:slide_ball_radius startAngle:0 endAngle:M_PI * 2 clockwise:NO];
    [Color_ff8bda set];
    [ballPath fill];
    
    //左边
    UIBezierPath *leftPolePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, _Vheight / 2 - slide_pole_hight / 2, _sliderBallCenterX - 10, slide_pole_hight) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(3.5, 3.5)];
    [Color_ff8bda set];
    [leftPolePath fill];
    
    //右边
    UIBezierPath *rightPolePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(_sliderBallCenterX, _Vheight / 2 - slide_pole_hight / 2, _Vwidth - _sliderBallCenterX - 10, slide_pole_hight) byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(slide_pole_hight / 2, slide_pole_hight / 2)];
    [Color_ff8bda set];
    rightPolePath.lineWidth = 0.5f;
    [rightPolePath stroke];
    
    //左边文本
    NSString *leftStr = [NSString stringWithFormat:@"%.1f%@",_currentSectionIndex * (_maxIndex - _minIndex) / _sectionsCount,_unit];
    CGSize size = [leftStr boundingRectWithSize:CGSizeMake(200.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil].size;
    if (_sliderBallCenterX + size.width / 2 >= _sliderWidth + 10.0) {
        [leftStr drawInRect:CGRectMake(_sliderWidth - size.width + 10, _Vheight / 2 + 12.0, size.width, size.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:Color_ff8bda}];
    }else{
        [leftStr drawInRect:CGRectMake(_sliderBallCenterX - size.width / 2, _Vheight / 2 + 12.0, size.width, size.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:Color_ff8bda}];
    }
    
    //右边文本
    NSString *rightStr = [NSString stringWithFormat:@"%.1f%@", _maxIndex,_unit];
    CGSize size1 = [rightStr boundingRectWithSize:CGSizeMake(200.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]} context:nil].size;
    if (_sliderBallCenterX + size.width / 2 >= _Vwidth - size1.width - 10.0 ) {
    
    }else{
         [rightStr drawInRect:CGRectMake(_Vwidth - size1.width - 10, _Vheight / 2 + 12.0, size1.width, size1.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:Color_ff8bda}];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self showSlideWithTouch:touch];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self showSlideWithTouch:touch];
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self showSlideWithTouch:touch];
}

#pragma mark - setter
/*
//段数
@property (nonatomic, assign)NSInteger sectionsCount;
//最小的值
@property (nonatomic, assign)CGFloat   minIndex;
//最大的值
@property (nonatomic, assign)CGFloat   maxIndex;
//停止标志值
@property (nonatomic, assign)CGFloat   stopIndex;
//单位名称
@property (nonatomic, copy)NSString    *unit;
//停止方向
@property (nonatomic, assign)STOP_DIRECTION_TYPE type;
*/
- (void)setSectionsCount:(NSInteger)sectionsCount{
    _sectionsCount = sectionsCount;
    [self setNeedsDisplay];
}

- (void)setType:(STOP_DIRECTION_TYPE)type {
    _type = type;
}

- (void)setUnit:(NSString *)unit {
    _unit = [unit copy];
    [self setNeedsDisplay];
}

- (void)setMaxIndex:(CGFloat)maxIndex {
    _maxIndex = maxIndex;
    [self setNeedsDisplay];
}

- (void)setMinIndex:(CGFloat)minIndex {
    _minIndex = minIndex;
    [self setNeedsDisplay];
}

- (void)setStopIndex:(CGFloat)stopIndex {
    _stopIndex = stopIndex;
    [self setNeedsDisplay];
}

#pragma mark - Private
- (void)showSlideWithTouch:(UITouch *)touch {
    CGFloat X = [touch locationInView:self].x;
    if (X < 10 || X > _Vwidth - 10) {
        X = X < 10 ? 10 : _Vwidth - 10;
    }
    _currentSectionIndex = round((X - 10 )/ (_sliderWidth / _sectionsCount));
    _sliderBallCenterX = _currentSectionIndex * (_sliderWidth / _sectionsCount) + 10;
    if (_type == STOP_DIRECTION_TYPE_LEFT) {
        if (_currentSectionIndex < _stopIndex) {
            _currentSectionIndex = _stopIndex;
            _sliderBallCenterX = _currentSectionIndex * (_sliderWidth / _sectionsCount);
        }
    }else{
        if (_currentSectionIndex > _stopIndex) {
            _currentSectionIndex = _stopIndex;
            _sliderBallCenterX = _currentSectionIndex * (_sliderWidth / _sectionsCount);
        }
    }
    if (_block) {
        _block(_currentSectionIndex);
    }
    [self setNeedsDisplay];
}

@end
