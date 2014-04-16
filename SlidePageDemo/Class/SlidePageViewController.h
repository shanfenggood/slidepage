//
//  SlidePageViewController.h
//  SlidePageDemo
//
//  Created by shanfeng on 14/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidePageViewController : UIViewController

@property(nonatomic,assign) int maxLeftShow;
@property(nonatomic,assign) int maxRightShow;

-(void) SlideMainViewWithTx:(int)tx;
-(void) SlideLeftSideShow;
-(void) SlideDobuleSideHidden;
-(void) SlideRightSideShow;


-(void) SetMainControl:(UIViewController*)mainControl   rightSideBackgroundController:(UIViewController*)rightControl
    leftSideBackgroundController:(UIViewController*)leftControl;
- (void)slideView:(UIPanGestureRecognizer *)panGestureReconginzer;
@end
