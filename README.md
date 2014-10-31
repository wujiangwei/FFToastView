FFToastView
===========

Toast View Like Android For IOS

****** 可配置项 toast字体 一般toast展示时间  超长toast展示时间 ********

//config toast font and show time(normal toast text and long toast text)

//all the param can not be nil and bigger than zero

//if nil or not bigger than zero,it will invalid

    + (void)configFont:(UIFont *)toastFont normalTime:(CGFloat)normalTime longTime:(CGFloat)longTime

******提供4个方法*******

指定显示在某个view中

  - (void)showToast:(NSString *)message inView:(UIView *)superView;
  

  centerOffY: 显示toast距离屏幕中央的距离（可以为负值）
  
  - (void)showToast:(NSString *)message inView:(UIView *)superView centerOffY:(CGFloat)centerOffY;
  
  

指定显示在window中

  - (void)showToast:(NSString *)message;

  - (void)showToast:(NSString *)message centerOffY:(CGFloat)centerOffY;


********一些细节说明********

1、Toast最多显示三行，多出三行不予显示

2、对于超过kMessageCriticalLength（16）的message，toast显示的时间会比原来加长0.6s，方便用户阅读完毕

3、已经适配IOS8
