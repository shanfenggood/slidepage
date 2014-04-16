//
//  TabInfo.h
//  SlidePageDemo
//
//  Created by shanfeng on 15/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabInfo : NSObject

@property(strong) NSString* title;
@property(strong) UIViewController* viewController;


-(TabInfo*) initWithTitle:(NSString*)title controller:(UIViewController*) viewController;
@end
