//
//  LXSideViewControler.h
//  LXSideViewControlerDemo
//
//  Created by livesxu on 2018/9/5.
//  Copyright © 2018年 Livesxu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHeight [UIScreen mainScreen].bounds.size.height

#define kWidth [UIScreen mainScreen].bounds.size.width

#define kShitOutScale 0.1f//缩放比例

#define kShitOutTop 5//上间距

#define kShitOutRight 5//侧间距


@interface LXSideViewControler :UIViewController

typedef NS_ENUM(NSInteger, LXShowSide){//显示的界面
    
    LXshowLeft=0,
    
    LXshowCenter,
    
    LXshowRight
    
};

@property(nonatomic,assign) LXShowSide currentSide;

typedef NS_ENUM(NSInteger, LXSGRside){
    
    SGRLeft=0,
    
    SGRRight,
    
    SGRLeftAndRight
    
};

typedef NS_ENUM(NSInteger, LXAnimationType){
    
    LXAnimationTypeNone=0,
    
    LXAnimationTypeShitOut,
    
    
};

@property(nonatomic,assign)LXAnimationType currentAnimationType;

@property(nonatomic,strong)UISwipeGestureRecognizer *swipeLeft;//左手势

@property(nonatomic,strong)UISwipeGestureRecognizer *swipeRight;//右手势

@property(nonatomic,assign)BOOL isSGRAllExist;

@property(nonatomic,strong)CAKeyframeAnimation *kfAnimation;//帧动画

@property(nonatomic,assign)CGFloat distanceSeeLeft;//左边看到的中间视图的宽度

@property(nonatomic,assign)CGFloat distanceSeeRight;

@property(nonatomic,assign)CGFloat distanceTop;//距离上方的距离

@property(nonatomic,assign)CGFloat distanceBottom;

@property(nonatomic,strong)UIViewController *centerV;//中间的控制器

@property(nonatomic,strong)UIViewController *leftV;//左边的控制器

@property(nonatomic,strong)UIViewController *rightV;//右边的控制器


@property(nonatomic,assign)BOOL isShowShadow;//显示阴影

@property(nonatomic,assign)CGSize shadowOffset;

-(instancetype)initWithCenterVC:(UIViewController *)center leftVC:(UIViewController *)left rightVC:(UIViewController *)right;//创建

-(void)showLeft;

-(void)showCenter;

-(void)showRight;

-(void)addSGRinSide:(LXSGRside)SGRside;

-(void)removeSGRinSide:(LXSGRside)SGRside;

-(void)showCenterLeftDistance:(CGFloat)distanceSeeLeft andRightDistance:(CGFloat)distanceSeeRight;

-(void)showCenterTopDistance:(CGFloat)distanceTop andBottomDistance:(CGFloat)distanceBottom;

-(void)showCenterShadowConfigureWithOpacity:(CGFloat)opacity offset:(CGSize)size color:(CGColorRef)color;

@end
