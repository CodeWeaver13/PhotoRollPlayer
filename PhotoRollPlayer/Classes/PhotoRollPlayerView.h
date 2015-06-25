//
//  PhotoRollPlayerView.h
//  lovek12
//
//  Created by wangshiyu13 on 15/5/27.
//  Copyright (c) 2015年 lovek12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoButton.h"

@interface PhotoRollPlayerView : UIView
// 视图数组
@property (nonatomic, strong) NSArray *viewArray;
// pageControl
@property (nonatomic, weak) UIPageControl *pageControl;
@end
