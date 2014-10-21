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

//show in custom view
- (void)showToast:(NSString *)message inView:(UIView *)superView;
//centerOffY:距离屏幕中间的像素
- (void)showToast:(NSString *)message inView:(UIView *)superView centerOffY:(CGFloat)centerOffY;

//show toast in window
- (void)showToast:(NSString *)message;
- (void)showToast:(NSString *)message centerOffY:(CGFloat)centerOffY;

@end
