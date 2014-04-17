//
//  TabScrollViewController.h
//  SlidePageDemo
//
//  Created by shanfeng on 15/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabScrollViewController : UIViewController<UIGestureRecognizerDelegate>

-(void)switchPageWithIndex:(int)index;

-(TabScrollViewController*) initWithTabs:(NSArray*) tabs;

@end
