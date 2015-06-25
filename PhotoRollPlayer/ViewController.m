//
//  ViewController.m
//  PhotoRollPlayer
//
//  Created by wangshiyu13 on 15/6/25.
//  Copyright © 2015年 manyi. All rights reserved.
//

#import "ViewController.h"
#import "PhotoRollPlayerView.h"

@interface ViewController ()
@property (nonatomic, strong) PhotoRollPlayerView *rollPlayerView;
@end

@implementation ViewController

- (PhotoRollPlayerView *)rollPlayerView {
    if (_rollPlayerView == nil) {
        _rollPlayerView = [[PhotoRollPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (int i = 1; i < 5; i++) {
            PhotoButton *button = [[PhotoButton alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
            button.contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]]];
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [arrayM addObject:button];
        }
        _rollPlayerView.viewArray = arrayM;
    }
    return _rollPlayerView;
}

- (void)click:(PhotoButton *)btn {
    NSLog(@"%@", btn);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.rollPlayerView];
}

@end
