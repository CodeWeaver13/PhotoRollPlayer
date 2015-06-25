//
//  PhotoRollPlayerView.m
//  lovek12
//
//  Created by wangshiyu13 on 15/5/27.
//  Copyright (c) 2015年 lovek12. All rights reserved.
//

#import "PhotoRollPlayerView.h"
@interface PhotoView : UIView
@property (nonatomic, strong) UIView *subview;
@end

@implementation PhotoView
- (void)setSubview:(UIView *)subview {
    _subview = subview;
    _subview.frame = self.bounds;
    [self addSubview:_subview];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.subview.frame = frame;
    }
    return self;
}
@end

@interface PhotoRollPlayerView () <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) PhotoView *currentView;   // 当前imageView
@property (nonatomic, weak) PhotoView *nextView;      // 下一个imageView
@property (nonatomic, weak) PhotoView *preView;       //上一个imageView
@property (nonatomic, assign) BOOL isDragging;               //是否正在拖动
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation PhotoRollPlayerView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor blueColor];
    UIScrollView *scrollView =[[UIScrollView alloc] init];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    scrollView.frame = CGRectMake(0, 0, width, height);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [self.scrollView setContentSize:CGSizeMake(width * 3, height)];
    //  设置隐藏横向条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //  设置自动分页
    self.scrollView.pagingEnabled = YES;
    //  设置代理
    self.scrollView.delegate = self;
    //  设置当前点
    self.scrollView.contentOffset = CGPointMake(width, 0);
    //  设置是否有边界
    self.scrollView.bounces = NO;
    //  初始化当前视图
    PhotoView *currentView = [[PhotoView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    currentView.subview = self.viewArray[0];
    [self.scrollView addSubview:currentView];
    self.currentView = currentView;
    //  初始化下一个视图
    PhotoView *nextView = [[PhotoView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
    nextView.subview = self.viewArray[1];
    [self.scrollView addSubview:nextView];
    self.nextView = nextView;
    //  初始化上一个视图
    PhotoView *preView =[[PhotoView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    preView.subview = [self.viewArray lastObject];
    [self.scrollView addSubview:preView];
    self.preView = preView;
    // PageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.viewArray.count;
    pageControl.currentPage = 0;
    CGSize size = [pageControl sizeForNumberOfPages:self.viewArray.count];
    pageControl.frame = CGRectMake(self.bounds.size.width - size.width - 16, self.bounds.size.height - size.height, size.width, size.height);
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    //  设置时钟动画 定时器
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    //  将定时器添加到主线程
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)update:(NSTimer *)timer {
    //定时移动
    if (_isDragging == YES) return;
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x +=offSet.x;
    [self.scrollView setContentOffset:offSet animated:YES];
    if (offSet.x >= self.frame.size.width * 2) {
        offSet.x = self.frame.size.width;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDragging = YES;
}

//  停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isDragging = NO;
    [self pageForCurrentView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self pageForCurrentView];
}

- (void)pageForCurrentView {
    for (int i = 0; i < self.viewArray.count; i++) {
        if (self.currentView.subview == self.viewArray[i]) {
            self.pageControl.currentPage = i;
            return;
        }
    }
}

// 开始拖动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static unsigned long i = 0; //   当前展示的是第几张图片
    float offset = self.scrollView.contentOffset.x;
    if (self.nextView.subview == nil || self.preView.subview == nil) {
        //  加载下一个视图
        UIView *view1 = i == (self.viewArray.count - 1) ? self.viewArray[0] : self.viewArray[i + 1];
        _nextView.subview = view1;
        // 加载上一个视图
        UIView *view2 = i == 0 ? [self.viewArray lastObject] : self.viewArray[i - 1];
        _preView.subview = view2;
    }
    if(offset == 0) {
        _currentView.subview = _preView.subview;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _preView.subview = nil;
        if (i == 0) {
            i = self.viewArray.count - 1;
        } else{
            i -= 1;
        }
    }
    if (offset == scrollView.bounds.size.width * 2) {
        _currentView.subview = _nextView.subview;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        _nextView.subview = nil;
        if (i == self.viewArray.count - 1) {
            i  = 0;
        }else{
            i += 1;
        }
    }
}
@end
