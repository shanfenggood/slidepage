//
//  ViewController.m
//  SlidePageDemo
//
//  Created by shanfeng on 14/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import "ViewController.h"
#import "SlidePageViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MainViewController.h"
#import "TabScrollViewController.h"
#import "TabInfo.h"
@interface ViewController ()

{
    SlidePageViewController* _slideController;
}

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _slideController = [[SlidePageViewController alloc] init];
    
    
    
    
    
    [_slideController SetMainControl:
//        [[MainViewController alloc] init]
     
                [[TabScrollViewController alloc ] initWithTabs:
                @[
                  [[TabInfo alloc] initWithTitle:@"1" controller:   [[RightViewController alloc] init]],

                  [[TabInfo alloc] initWithTitle:@"2" controller:[[LeftViewController alloc] init]],
                   [[TabInfo alloc] initWithTitle:@"3" controller:[[RightViewController alloc] init]],
                   [[TabInfo alloc] initWithTitle:@"4" controller:[[LeftViewController alloc] init]]
                   ]]
       rightSideBackgroundController:
//         [[RightViewController alloc] init]
     nil
        leftSideBackgroundController:
//     nil
            [[LeftViewController alloc] init]
     ];
    
    _slideController.maxLeftShow = 200;
    _slideController.maxRightShow = 100;
    
    [self.view addSubview:_slideController.view];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
