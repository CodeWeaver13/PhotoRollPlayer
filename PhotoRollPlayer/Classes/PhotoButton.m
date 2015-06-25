//
//  PhotoButton.m
//  lovek12
//
//  Created by wangshiyu13 on 15/6/11.
//  Copyright © 2015年 manyi. All rights reserved.
//

#import "PhotoButton.h"


@implementation PhotoButton

- (void)setContentImageView:(UIImageView *)contentImageView {
    _contentImageView = contentImageView;
    [self addSubview:_contentImageView];
    _contentImageView.frame = self.frame;
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentImageView.frame = frame;
    }
    return self;
}

@end