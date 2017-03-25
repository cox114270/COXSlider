//
//  CoxSegmentSlider.h
//  CustomSlider
//
//  Created by mac on 17/3/25.
//  Copyright © 2017年 _. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SlideBlock)(NSInteger);
typedef NS_ENUM(NSInteger, STOP_DIRECTION_TYPE){
    STOP_DIRECTION_TYPE_LEFT = 0,
    STOP_DIRECTION_TYPE_RIGHT,
};
@interface CoxSegmentSlider : UIControl
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
//回调
@property (nonatomic, strong)SlideBlock block;

- (instancetype)initWithFrame:(CGRect)frame
                sectionsCount:(NSUInteger)count
                     minIndex:(CGFloat)min
                     maxIndex:(CGFloat)max
                    stopIndex:(CGFloat)stop
                stopDirection:(STOP_DIRECTION_TYPE)type
                     showUnit:(NSString *)unit;
@end
