//
//  MainViewController.m
//  SlidePageDemo
//
//  Created by shanfeng on 14/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UIPanGestureRecognizer* gesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_panGesture:)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_panGesture:(UIPanGestureRecognizer *)panGestureReconginzer
{
    CGFloat translation = [panGestureReconginzer translationInView:self.view].x;
    NSLog(@"%f",translation);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveTouch:(UITouch *)touch {
    
    return YES;
    
//    CGPoint touchLocation = [touch locationInView:self.view];
//    return !CGRectContainsPoint(self.activeTab.frame, touchLocation);
}
@end
