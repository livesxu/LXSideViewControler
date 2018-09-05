//
//  LXSideViewControler.m
//  LXSideViewControlerDemo
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import "LXSideViewControler.h"

@interface LXSideViewControler ()

@end

@implementation LXSideViewControler

CGFloat const distanceSeeLeftDefault =50;

CGFloat const distanceSeeRightDefault =50;

CGFloat const distanceTopDefault =0;

CGFloat const distanceBottomDefault =0;

#pragma mark-创建

-(instancetype)initWithCenterVC:(UIViewController *)center leftVC:(UIViewController *)left rightVC:(UIViewController *)right;{
    
    if ([super init]) {
        
        _centerV=center;
        
        _leftV=left;
        
        _rightV=right;
        
        _isShowShadow=NO;//默认无阴影
        
        _currentAnimationType=LXAnimationTypeNone;//默认侧滑动画,LXAnimationTypeNone
        
        
        [self.view addSubview:_centerV.view];
        
        self.currentSide=LXshowCenter;
        
        [self showCenter];
        
        [self addSGRinSide:SGRLeftAndRight];
        
        _distanceSeeLeft=distanceSeeLeftDefault;
        
        _distanceSeeRight=distanceSeeRightDefault;
        
        _distanceTop=distanceTopDefault;
        
        _distanceBottom=distanceBottomDefault;
        
    }
    return self;
}

#pragma mark-手势和触发动作

-(void)addLeftSwipe{
    _swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftAction)];
    
    _swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:_swipeLeft];
    
}

-(void)swipeLeftAction{
    
    NSLog(@"向左清扫");
    
    switch (self.currentSide) {
            
        case LXshowLeft:
            
            [self showCenter];
            
            break;
            
        case LXshowCenter:
            
            [self showRight];
            
            break;
            
        default:
            
            break;
            
    }
}



-(void)addRightSwipe{
     _swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightAction)];
    
    _swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:_swipeRight];
}



-(void)swipeRightAction{
    
    NSLog(@"向右清扫");
    
    switch (self.currentSide) {
            
        caseLXshowRight:
            
            [self showCenter];
            
            break;
            
        case LXshowCenter:
            
            [self showLeft];
            
            break;
        default:
            
            break;
    }
}



#pragma mark-添加移除手势

-(void)addSGRinSide:(LXSGRside)SGRside{
    
    switch (SGRside) {
            
        case SGRLeft:
            
            [self addLeftSwipe];
            
            break;
            
        case SGRRight:
            
            [self addRightSwipe];
            
            break;
            
        case SGRLeftAndRight:
            
            [self addRightSwipe];
            
            [self addLeftSwipe];
            
            self.isSGRAllExist=YES;
            
            break;
        default:
            
            break;
            
    }
}



-(void)removeSGRinSide:(LXSGRside)SGRside{
    
    switch (SGRside) {
            
        case SGRLeft:
            
            [self.view removeGestureRecognizer:_swipeLeft];
            
            break;
            
        case SGRRight:
            
            [self.view removeGestureRecognizer:_swipeRight];
            
            break;
            
        case SGRLeftAndRight:
            
            [self.view removeGestureRecognizer:_swipeLeft];
            
            [self.view removeGestureRecognizer:_swipeRight];
            
            self.isSGRAllExist=NO;
            
            break;
            
        default:
            
            break;
            
    }
}



#pragma mark-显示中左右侧视图

-(void)showCenter;{
    
    if (_currentAnimationType==LXAnimationTypeNone) {
        
        [UIView animateWithDuration:.3 animations:^{
            
            _centerV.view.frame=self.view.bounds;
            
        }];
        
    }
    if (_currentAnimationType==LXAnimationTypeShitOut) {
        
        [UIView animateWithDuration:.3 animations:^{
            
            _centerV.view.transform=CGAffineTransformIdentity;
            
        }];
        
    }
    
    if ([self.view viewWithTag:1001]||[self.view viewWithTag:1002]) {
        
        
        
        [[self.view viewWithTag:1001]removeFromSuperview];
        
        [[self.view viewWithTag:1002]removeFromSuperview];
        
    }
    
    if (_leftV) {
        
        [_leftV removeFromParentViewController];
        
    }
    
    if (_rightV) {
        
        [_rightV removeFromParentViewController];
        
    }
    self.currentSide=LXshowCenter;
}



-(void)showLeft;{
    
    
    
    _leftV.view.frame=CGRectMake(0,0, kWidth,kHeight);
    
    
    
    [self.view insertSubview:_leftV.view belowSubview:_centerV.view];
    
    if (_currentAnimationType==LXAnimationTypeNone) {
        
        
        
        _leftV.view.frame=CGRectMake(0,0, kWidth-_distanceSeeLeft,kHeight);
        
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            _centerV.view.frame=CGRectMake(kWidth-_distanceSeeLeft,_distanceTop, kWidth,kHeight-_distanceBottom-_distanceTop);
            
            
            
            _shadowOffset=CGSizeMake(-ABS(_shadowOffset.width),_shadowOffset.height);
            
            self.centerV.view.layer.shadowOffset=_shadowOffset;
            
        }];
        
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];//返回中心的按钮
        
        button.frame=CGRectMake(kWidth-_distanceSeeLeft,_distanceTop, _distanceSeeLeft,kHeight-_distanceBottom-_distanceTop);
        
        button.backgroundColor=[UIColor clearColor];
        
        button.tag=1001;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(showCenter)forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (_currentAnimationType==LXAnimationTypeShitOut) {
        
        [UIView animateWithDuration:.3 animations:^{
             _centerV.view.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(kShitOutScale,kShitOutScale), CGAffineTransformMakeTranslation(kWidth/2-kWidth/(1.0/kShitOutScale)/2-kShitOutRight, -(kHeight/2-kHeight/(1.0/kShitOutScale)/2-kShitOutTop)));
            
        }];
        
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];//返回中心的按钮
        
        button.frame=CGRectMake(kWidth-kShitOutRight-kWidth*kShitOutScale,kShitOutTop, kWidth*kShitOutScale,kHeight*kShitOutScale);
        
        button.backgroundColor=[UIColor clearColor];
        
        button.tag=1001;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(showCenter)forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    
    
    
    
    self.currentSide=LXshowLeft;
    
}



-(void)showRight;{
    
    
    
    _rightV.view.frame=CGRectMake(0,0, kWidth,kHeight);
    
    
    
    [self.view insertSubview:_rightV.view belowSubview:_centerV.view];
    
    
    
    
    
    if (_currentAnimationType==LXAnimationTypeNone) {
        
        _rightV.view.frame=CGRectMake(_distanceSeeRight,0, kWidth-_distanceSeeRight,kHeight);
        
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            _centerV.view.frame=CGRectMake(_distanceSeeRight-kWidth,_distanceTop, kWidth,kHeight-_distanceBottom-_distanceTop);
            
            
            
            _shadowOffset=CGSizeMake(ABS(_shadowOffset.width),_shadowOffset.height);
            
            self.centerV.view.layer.shadowOffset=_shadowOffset;
            
            
            
        }];
        
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];//返回中心的按钮
        
        button.frame=CGRectMake(0,_distanceTop,_distanceSeeRight, kHeight-_distanceBottom-_distanceTop);
        
        button.backgroundColor=[UIColor clearColor];
        
        button.tag=1002;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(showCenter)forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
    }
    
    if (_currentAnimationType==LXAnimationTypeShitOut) {
        
        
        
        [UIView animateWithDuration:.3 animations:^{
            
            _centerV.view.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(kShitOutScale,kShitOutScale), CGAffineTransformMakeTranslation(-(kWidth/2-kWidth/(1.0/kShitOutScale)/2-kShitOutRight), -(kHeight/2-kHeight/(1.0/kShitOutScale)/2-kShitOutTop)));
            
        }];
        
        
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];//返回中心的按钮
        
        button.frame=CGRectMake(kShitOutRight,kShitOutTop, kWidth*kShitOutScale,kHeight*kShitOutScale);
        
        button.backgroundColor=[UIColor clearColor];
        
        button.tag=1002;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(showCenter)forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
    }
    
    
    
    
    
    self.currentSide=LXshowRight;
    
    
    
}



#pragma mark-距离设置

-(void)showCenterLeftDistance:(CGFloat)distanceSeeLeft andRightDistance:(CGFloat)distanceSeeRight;{
    
    
    
    _distanceSeeLeft=distanceSeeLeft;
    
    _distanceSeeRight=distanceSeeRight;
    
    
    
}

-(void)showCenterTopDistance:(CGFloat)distanceTop andBottomDistance:(CGFloat)distanceBottom;{
    
    _distanceTop=distanceTop;
    
    _distanceBottom=distanceBottom;
    
}

#pragma mark-阴影的配置

-(void)showCenterShadowConfigureWithOpacity:(CGFloat)opacity offset:(CGSize)size color:(CGColorRef)color;{
    
    if (self.isShowShadow==YES) {
        
        self.centerV.view.layer.shadowOpacity=opacity;
        
        
        
        self.shadowOffset=size;
        
        
        
        self.centerV.view.layer.shadowColor=color;
        
    }
    
}





#pragma mark-另类动画制作,代码中并未用到此处,用于增加LXAnimationType测试用的



-(BOOL)animatedRotationY{
    
    
    
    _kfAnimation=[CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    
    
    CGFloat angle=M_PI;
    
    
    
    _kfAnimation.values=@[@0,@(angle/3),@(angle*2/3),@(angle),@(angle*4/3)];
    
    
    
    
    
    CAKeyframeAnimation *translation=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    translation.values=@[@0,@(kWidth/8),@(kWidth/4),@(kWidth*3/8),@(kWidth/2)];
    
    
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    
    
    
    group.animations=@[_kfAnimation,
                       
                       translation
                       
                       ];
    
    
    
    
    
    group.duration=1;
    
    group.repeatCount=1;
    
    
    
    //完成动画时，最终状态是否需要保留
    
    group.removedOnCompletion =NO;
    
    group.fillMode =kCAFillModeBoth;
    
    
    
    [_centerV.view.layer addAnimation:group forKey:nil];
    
    
    
    //    _centerV.view.layer.transform=CATransform3DMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
    
    
    
    
    
    
    
    return YES;
    
}

-(void)shitOut{
    
    [UIView animateWithDuration:.3 animations:^{
        
        _centerV.view.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(.2,.2), CGAffineTransformMakeTranslation(kWidth/2-60, -kHeight/2+60));
        
    }];
    
}



@end


