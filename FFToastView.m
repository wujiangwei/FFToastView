//
//  FFToastView.m
//
//  Created by Kevin on 14-3-17.
//  Copyright (c) 2014年 Wu. All rights reserved.
//

#import "FFToastView.h"
#import <QuartzCore/QuartzCore.h>

static UIFont *_toastFont = nil;
static CGFloat _animationDelayNormal = 1.2;
static CGFloat _animationDelayLong = 1.8;

#define kHorizontalPadding          (20.0)
#define kVerticalPadding            (10.0)
#define kCornerRadius               (8.0)

#define kMaxLines                   (3)
#define kMaxWidth                   ([UIScreen mainScreen].bounds.size.width * 0.75)
#define kMaxHeight                  (kMaxWidth * 0.4)

#define kFadeDuration               (0.3)
#define kOpacity                    (0.8)

#define kMessageCriticalLength      (16)


@implementation FFToastView

#pragma mark - 
#pragma mark - Singleton Stuff

static FFToastView *_instance = nil;

+ (id)sharedInstance
{
    @synchronized(self)
    {
        
        if (!_instance) {
            _instance = [[self alloc] init];
            CGFloat fontSize = 15.0f;
            if ([UIScreen mainScreen].bounds.size.width > 320.f) {
                fontSize = 16.0f;
            }
            [FFToastView configFont:[UIFont systemFontOfSize:fontSize] normalTime:_animationDelayNormal longTime:_animationDelayLong];
        }
    }
    
    return _instance;
}

+ (void)configFont:(UIFont *)toastFont normalTime:(CGFloat)normalTime longTime:(CGFloat)longTime
{
    if (toastFont != nil) _toastFont = toastFont;
    if (normalTime > 0) _animationDelayNormal = normalTime;
    if (longTime > 0)   _animationDelayLong = longTime;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (!_instance) {
            _instance = [super allocWithZone:zone];
            return _instance;
        }
    }
    
    return nil;   
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kOpacity];
        self.layer.cornerRadius = kCornerRadius;     
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOpacity:0.8];
        [self.layer setShadowRadius:6.0];
        [self.layer setShadowOffset:CGSizeMake(4.0, 4.0)];
        
        UILabel *label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:_toastFont];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setNumberOfLines:kMaxLines];
        [label setTextColor:[UIColor whiteColor]];
        [self addSubview:label];
        _label = label;
        _stoped = YES;
        _refreshed = NO;
    }
    return self;
}

- (void)startAnimate
{   
    [UIView beginAnimations:@"fade_in" context:( void*)self];
    [UIView setAnimationDuration:kFadeDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self setAlpha:kOpacity];
    [UIView commitAnimations];
}

- (void)showToast:(NSString *)message inView:(UIView *)superView
{
    [self showToast:message inView:superView centerOffY:0];
}

- (void)showToast:(NSString *)message inView:(UIView *)superView centerOffY:(CGFloat)centerOffY
{
    if ([self isToastMessageEqual:message]) {
        return;
    }
    
    CGSize text_size = [message sizeWithFont:_toastFont constrainedToSize:CGSizeMake(kMaxWidth, kMaxHeight) lineBreakMode:_label.lineBreakMode];
    [_label setText:message];
    [_label setFrame:CGRectMake(kHorizontalPadding, kVerticalPadding, text_size.width, text_size.height)];
    [self setFrame:CGRectMake(0.0f, 0.0f, text_size.width + kHorizontalPadding * 2, text_size.height + kVerticalPadding * 2)];
    self.center = CGPointMake(superView.frame.size.width / 2, superView.frame.size.height/2 - self.frame.size.height / 2 - kVerticalPadding + centerOffY);
    
    if (_stoped) {
        [self setAlpha:0.0f];
        self.hidden = NO;
        _stoped = NO;
        [superView addSubview:self];
    }else
    {
        _refreshed = YES;
    }
    
    [self startAnimate];
}


- (void)showToast:(NSString *)message {
    UIView *keywindow = [UIApplication sharedApplication].keyWindow;
    [[FFToastView sharedInstance] showToast:message centerOffY:(CGRectGetHeight(keywindow.bounds) * 0.12)];
}

- (BOOL)isToastMessageEqual:(NSString *)newMessage
{
    return [_label.text isEqualToString:newMessage] && !_stoped;
}

- (void)showToast:(NSString *)message centerOffY:(CGFloat)centerOffY {
    
    if ([self isToastMessageEqual:message]) {
        return;
    }
    
    UIWindow *superView = [[UIApplication sharedApplication] keyWindow];
    
    CGSize text_size = [message sizeWithFont:_toastFont constrainedToSize:CGSizeMake(kMaxWidth, kMaxHeight) lineBreakMode:_label.lineBreakMode];
    [_label setText:message];
    [_label setFrame:CGRectMake(kHorizontalPadding, kVerticalPadding, text_size.width, text_size.height)];
    [self setFrame:CGRectMake(0.0f, 0.0f, text_size.width + kHorizontalPadding * 2, text_size.height + kVerticalPadding * 2)];
    self.center = CGPointMake(superView.frame.size.width / 2, superView.frame.size.height/2 - self.frame.size.height / 2 - kVerticalPadding - 55.0f + centerOffY);
    
    if (_stoped) {
        [self setAlpha:0.0f];
        self.hidden = NO;
        _stoped = NO;
        [superView addSubview:self];
    }else{
        _refreshed = YES;
    }
    [self startAnimate];
}

#pragma mark - Animation Delegate Method

- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context
{    
    UIView *toast = (__bridge UIView *)context;
    
    if([animationID isEqualToString:@"fade_in"]) {
        [UIView beginAnimations:@"fade_out" context:context];
        [UIView setAnimationDelay:_label.text.length > kMessageCriticalLength ? _animationDelayLong : _animationDelayNormal];
        [UIView setAnimationDuration:kFadeDuration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [toast setAlpha:0.0];
        [UIView commitAnimations];
    } 
    else if ([animationID isEqualToString:@"fade_out"]) {
        if (_refreshed) {
            //not remove because of refresh
            _refreshed = NO;
        }else{
            toast.hidden = YES;
            [toast removeFromSuperview];
            _stoped = YES;
        }
    }
}

@end
