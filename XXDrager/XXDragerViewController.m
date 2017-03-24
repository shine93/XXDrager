//
//  XXDragerViewController.m
//  XXDrager
//
//  Created by shine on 2017/3/6.
//  Copyright © 2017年 shine. All rights reserved.
//

#import "XXDragerViewController.h"
#define XXScreenW [UIScreen mainScreen].bounds.size.width
#define XXScreenH [UIScreen mainScreen].bounds.size.height
#define XXMaxSetY 100
#define XXTargetR XXScreenW - XXMaxSetY
#define XXTargetL -(XXScreenW - XXMaxSetY)

@interface XXDragerViewController ()

@end

@implementation XXDragerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化，将三个view添加到self.view中
    
    [self setup];
    
    //给mainView添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
    //pan.delegate = self;
    [self.mainView addGestureRecognizer:pan];
    
    //给self.view添加一个点击手势（当滑动结束，点击屏幕，就会返回到mainView）
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handelTap:)];
    [self.view addGestureRecognizer:tap];
    
}

//点击手势
- (void)handelTap:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
    
}

//拖拽手势
- (void)handelPan:(UIPanGestureRecognizer *)pan{
    
    //这里不用self.mainView.transform 修改偏移量，因为抽屉效果要是mainView的高度也发生变化
    CGPoint offset = [pan translationInView:self.mainView];
    self.mainView.frame = [self frameWithOffset:offset.x];
    
    /*
    //让mainView跟随手指移动
    CGPoint offset = [pan translationInView:self.mainView];
    
    self.mainView.transform = CGAffineTransformTranslate(self.mainView.transform, offset.x, offset.y);
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    */
    //判断拖拽的方向（用x轴的偏移量判断，偏移量为正数则是向右划，为负则是向左划）
    if (self.mainView.frame.origin.x > 0) {
        //向右划
        NSLog(@"右划");
        //让leftView显示，让rightView隐藏
        self.rightView.hidden = YES;
        self.leftView.hidden = NO;
        
    }else{
        //向左划
        NSLog(@"左划");
        self.rightView.hidden = NO;
        self.leftView.hidden = YES;
    }
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
    //当手指松开的时候自动定位
    //如果mainView的x值大于屏幕的一半则自动定位到离右边缘100的距离
    //如果mainView的最大的x值小于屏幕的一半，则自动定位到离左边缘100的距离
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat target = 0;
        if (self.mainView.frame.origin.x > (XXScreenW / 2)){
            target = XXTargetR;
            
        }else if(CGRectGetMaxX(self.mainView.frame) < (XXScreenW / 2)){
            target = XXTargetL;
        }
        //NSLog(@"target=%f,self.mainView.frame.origin.x = %f",target, self.mainView.frame.origin.x);
        [UIView animateWithDuration:0.5 animations:^{
            self.mainView.frame = [self frameWithOffset:(target - self.mainView.frame.origin.x)];
        }];
        
    }
    
    
    //复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
}

- (CGRect)frameWithOffset:(CGFloat)offsetX{
    CGRect mainFrame = self.mainView.frame;
    mainFrame.origin.x += offsetX;
    mainFrame.origin.y = fabs(XXMaxSetY * mainFrame.origin.x / XXScreenW);
    //NSLog(@"ld",XXMaxSetY);
    mainFrame.size.height = XXScreenH - 2 * mainFrame.origin.y;
    NSLog(@"%@",NSStringFromCGPoint(mainFrame.origin));
    return mainFrame;
}


- (void)setup{
    
    //leftView
    UIView *leftView = [[UIView alloc] initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor blueColor];
    _leftView = leftView;
    [self.view addSubview:leftView];
    
    //rightView
    UIView *rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    rightView.backgroundColor = [UIColor greenColor];
    _rightView = rightView;
    [self.view addSubview:rightView];
    
    //mianView
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor redColor];
    _mainView = mainView;
    [self.view addSubview:mainView];
}




@end
