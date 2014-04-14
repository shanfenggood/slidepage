//
//  SlidePageViewController.m
//  SlidePageDemo
//
//  Created by Tim on 14/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import "SlidePageViewController.h"

@interface SlidePageViewController ()
{
    UIViewController* _mainController;
    UIViewController* _rightSideBackgroundController;
    UIViewController* _leftSideBackgroundController;
    
    
    
}

@end



@implementation SlidePageViewController



-(void) SetMainControl:(UIViewController*)mainControl   rightSideBackgroundController:(UIViewController*)rightControl
    leftSideBackgroundController:(UIViewController*)leftControl

{
    //init
    mainControl?_mainController=mainControl:NSLog(@"no mainController");
    
    rightControl?_rightSideBackgroundController = rightControl:NSLog(@"no rightController");
    
    leftControl?_leftSideBackgroundController = leftControl:NSLog(@"no leftController");
    
}


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
    
    [self addChildViewController:_mainController];
    [self addChildViewController:_rightSideBackgroundController];
    [self addChildViewController:_leftSideBackgroundController];

    
    
    _rightSideBackgroundController?[self.view addSubview: _rightSideBackgroundController.view]:false;
    _leftSideBackgroundController?[self.view addSubview: _leftSideBackgroundController.view]:false;
    _mainController?[self.view addSubview: _mainController.view]:false;
    

    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideView:)]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private function

-(UIView*) _leftSideView
{
    return _leftSideBackgroundController?_leftSideBackgroundController.view:nil;
}
-(UIView*) _rightSideView
{
    return _rightSideBackgroundController?_rightSideBackgroundController.view:nil;
}
-(UIView*) _mainView
{
    return _mainController?_mainController.view:nil;
}

- (void)slideView:(UIPanGestureRecognizer *)panGestureReconginzer
{
    CGFloat translation = [panGestureReconginzer translationInView:self.view].x;
    [self _mainView].transform = CGAffineTransformMakeTranslation(translation, 0);
}

@end
