//
//  COXCustomSlider.h
//  CustomSlider
//
//  Created by mac on 17/3/22.
//  Copyright © 2017年 _. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchEndCallBackBlock)(NSInteger);

typedef NS_ENUM(NSInteger, DIRECTION){
    DIRECTION_LEFT = 0,
    DIRECTION_RIGHT ,
};
@interface COXCustomSlider : UIView

@property (nonatomic,strong) TouchEndCallBackBlock block;


/**
 *初始化方法
 *frame:不解释
 *index：临界值的段标（例如十二段，在第五段之前不能向左拖，就传5）
 *direction:禁止滑动的方向，向左向右
 *segments:段数
 *unit：单位（例如小时、km）
 */
- (instancetype)initWithFrame:(CGRect)frame unSlidableIndex:(NSInteger)index forbiddenDirection:(DIRECTION)direction numbersOfSegments:(NSInteger)segments unit:(NSString *)unit;
@end
