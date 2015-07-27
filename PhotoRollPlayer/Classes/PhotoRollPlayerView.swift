//
//  PhotoRollPlayerView.swift
//  lovek12
//
//  Created by wangshiyu13 on 15/6/25.
//  Copyright © 2015年 manyi. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    var subview: UIView? {
        didSet {
            if subview != nil {
                subview!.frame = self.bounds
                self.addSubview(subview!)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subview?.frame = frame
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PhotoRollPlayerView: UIView, UIScrollViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 定义属性
    // 视图数组
    var viewArray: NSArray?
    // pageControl
    lazy var pageControl: UIPageControl = {
        // PageControl
        let page = UIPageControl()
        page.numberOfPages = self.viewArray!.count
        page.currentPage = 0;
        let size = page.sizeForNumberOfPages(self.viewArray!.count)
        page.frame = CGRectMake(self.bounds.size.width - size.width - 16, self.bounds.size.height - size.height, size.width, size.height)
        page.pageIndicatorTintColor = UIColor.blueColor()
        page.currentPageIndicatorTintColor = UIColor.redColor()
        self.addSubview(page)
        return page
    }()
    
    var scrollView = UIScrollView()
    
    // 当前imageView
    lazy var currentView: PhotoView = {
        //  初始化当前视图
        let current = PhotoView(frame:CGRectMake(self.frame.width, 0, self.frame.width, self.frame.height))
        current.subview = (self.viewArray![0] as! UIView)
        return current
    }()
    
    // 下一个imageView
    lazy var nextView: PhotoView = {
        //  初始化下一个视图
        let next = PhotoView(frame:CGRectMake(self.frame.width * 2, 0, self.frame.width, self.frame.height))
        next.subview = (self.viewArray![1] as! UIView)
        return next
    }()
    
    //上一个imageView
    lazy var preView: PhotoView = {
        //  初始化上一个视图
        let pre = PhotoView(frame:CGRectMake(0, 0, self.frame.width, self.frame.height))
        pre.subview = (self.viewArray!.lastObject as! UIView)
        return pre
        }()
    
    //是否正在拖动
    var isDragging: Bool?
    lazy var timer: NSTimer = {
        return NSTimer(timeInterval: 5.0, target: self, selector: "update:", userInfo: nil, repeats: true)
    }()
 
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.blueColor()
        
        self.scrollView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        self.scrollView.contentSize = CGSizeMake(self.frame.width * 3, self.frame.height)
        //  设置自动分页
        self.scrollView.pagingEnabled = true
        //  设置隐藏横向条
        self.scrollView.showsHorizontalScrollIndicator = false
        //  设置代理
        self.scrollView.delegate = self
        //  设置当前点
        self.scrollView.contentOffset = CGPointMake(self.frame.width, 0)
        //  设置是否有边界
        self.scrollView.bounces = false
        self.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.currentView)
        self.scrollView.addSubview(self.nextView)
        self.scrollView.addSubview(self.preView)
        //  将定时器添加到主线程
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode:NSRunLoopCommonModes)
        self.bringSubviewToFront(self.pageControl)
    }
    
    // MARK: - 触发事件
    func update(timer: NSTimer) {
        //定时移动
        if isDragging == false {
            var offSet = self.scrollView.contentOffset
            offSet.x += offSet.x
            self.scrollView.setContentOffset(offSet, animated: true)
            if (offSet.x >= self.frame.size.width * 2) {
                offSet.x = self.frame.size.width;
            }
        }
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isDragging = true
    }
    //  停止滚动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        isDragging = false
        self.pageForCurrentView()
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.pageForCurrentView()
    }
    
    func pageForCurrentView() {
        for i in 0..<self.viewArray!.count {
            if (self.currentView.subview == self.viewArray![i] as? UIView) {
                self.pageControl.currentPage = i
                return
            }
        }
    }
    // 开始拖动
    var i: Int = 0 //   当前展示的是第几张图片
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = self.scrollView.contentOffset.x
        if (self.nextView.subview == nil) || (self.preView.subview == nil) {
            //  加载下一个视图
            let view1: UIView = (i == self.viewArray!.count - 1 ? self.viewArray![0] : self.viewArray![i + 1]) as! UIView
            self.nextView.subview = view1
            // 加载上一个视图
            let view2: UIView = (i == 0 ? self.viewArray!.lastObject : self.viewArray![i - 1]) as! UIView
            self.preView.subview = view2
        }
        if offset == 0 {
            currentView.subview = preView.subview
            scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0)
            preView.subview = nil
            if (i == 0) {
                i = self.viewArray!.count - 1
            } else{
                i -= 1
            }
        }
        if offset == scrollView.bounds.size.width * 2 {
            currentView.subview = nextView.subview
            scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0)
            nextView.subview = nil
            if i == self.viewArray!.count - 1 {
                i = 0
            }else{
                i += 1
            }
        }
    }
}
