//
//  FFToastView.h
//
//  Created by Kevin on 14-3-17.
//  Copyright (c) 2014年 Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFToastView : UIView
{
    @private 
    UILabel *_label;
    BOOL _stoped;
    BOOL _refreshed;
}

//get handle
+ (id)sharedInstance;

//config toast font and show time(normal toast text and long toast text)
//all the param can not be nil and bigger than zero
//if nil or not bigger than zero,it will invalid
+ (void)configFont:(UIFont *)toastFont normalTime:(CGFloat)normalTime longTime:(CGFloat)longTime;

//show in custom view
- (void)showToast:(NSString *)message inView:(UIView *)superView;
//centerOffY:距离屏幕中间的像素
- (void)showToast:(NSString *)message inView:(UIView *)superView centerOffY:(CGFloat)centerOffY;

//show toast in window
- (void)showToast:(NSString *)message;
- (void)showToast:(NSString *)message centerOffY:(CGFloat)centerOffY;

@end
