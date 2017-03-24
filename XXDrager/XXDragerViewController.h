//
//  XXDragerViewController.h
//  XXDrager
//
//  Created by shine on 2017/3/6.
//  Copyright © 2017年 shine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXDragerViewController : UIViewController

//封装的时候，不允许修改我暴漏在外面的三个属性（三个view不能修改）
//主（中间view）
@property (weak, nonatomic, readonly) UIView *mainView;

//左边view
@property (weak, nonatomic, readonly) UIView *leftView;

//右边view
@property (weak, nonatomic, readonly) UIView *rightView;
@end
