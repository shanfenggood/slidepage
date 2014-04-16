//
//  TabInfo.m
//  SlidePageDemo
//
//  Created by shanfeng on 15/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import "TabInfo.h"

@implementation TabInfo

-(TabInfo*) initWithTitle:(NSString*)title controller:(UIViewController*) viewController
{

    if (self = [super init]){
        self.title = title;
        self.viewController = viewController;
    }
    return self;
}

@end
