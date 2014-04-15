//
//  SlidePageViewController.m
//  SlidePageDemo
//
//  Created by shanfeng on 14/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import "SlidePageViewController.h"

@interface SlidePageViewController ()
{
    UIViewController* _mainController;
    UIViewController* _rightSideBackgroundController;
    UIViewController* _leftSideBackgroundController;
    
    int _mainViewPreTransformTx;
    
}

@end



@implementation SlidePageViewController

#pragma mark slide interface
-(void) SlideLeftSideShow
{
    
    [self _rightSideView]?[self _rightSideView].hidden=YES:false;
    [self _leftSideView]?[self _leftSideView].hidden=NO:false;
    [self _animationSlideToX:_maxLeftShow?_maxLeftShow:[self _mainView].frame.size.width duration:0.3f];

}
-(void) SlideDobuleSideHidden{
    [self _animationSlideToX:0 duration:0.3f];
}

-(void) SlideRightSideShow{
    [self _rightSideView]?[self _rightSideView].hidden=NO:false;
    [self _leftSideView]?[self _leftSideView].hidden=YES:false;
    
    [self _animationSlideToX:_maxRightShow?-_maxRightShow:-[self _mainView].frame.size.width duration:0.3f];

}


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
    

    if(_rightSideBackgroundController){
        [self addChildViewController:_rightSideBackgroundController];
        [self.view addSubview: _rightSideBackgroundController.view];
    }
    if(_leftSideBackgroundController){
        [self addChildViewController:_leftSideBackgroundController];
        [self.view addSubview: _leftSideBackgroundController.view];
    }
    if(_mainController){
        [self addChildViewController:_mainController];
        [self.view addSubview: _mainController.view];
    }
    

    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_slideView:)]];
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

-(void) _transformToX:(int)x
{
    CGAffineTransform t = CGAffineTransformMakeTranslation(x,0);
    
    double scaleRate  = 1;
    if (x>0) {
        scaleRate -= 0.05 * abs(x)/(_maxLeftShow?_maxLeftShow:self.view.frame.size.width);
    }else if(x<0){
        scaleRate -= 0.05 * abs(x)/(_maxRightShow?_maxRightShow:self.view.frame.size.width);
    }
    [self _mainView].transform = CGAffineTransformScale(t,scaleRate,scaleRate);

}
-(void) _animationSlideToX:(int) x duration:(NSTimeInterval)interval{
    [UIView animateWithDuration:interval animations:^{
        
        [self _transformToX:x];
        
    } completion:^(BOOL finished) {
        
        _mainViewPreTransformTx =[self _mainView].transform.tx;
        
    }];

}
- (void)_slideView:(UIPanGestureRecognizer *)panGestureReconginzer
{
    CGFloat translation = [panGestureReconginzer translationInView:self.view].x + _mainViewPreTransformTx;
    
    //set not slide more
    if (![self _leftSideView] && ([self _mainView].frame.origin.x+translation) >=0)
    {
        translation = 0;
    }
    if (![self _rightSideView] && ([self _mainView].frame.origin.x+translation )<0) {
        translation = 0;
    }
    //set not slide more
    if (_maxRightShow && translation<-_maxRightShow ) {
        translation = -_maxRightShow;
    }
    if (_maxLeftShow && translation>_maxLeftShow ) {
        translation = _maxLeftShow;
    }
    if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
        int dx = [self _mainView].transform.tx;

        if (0<abs(dx) && abs(dx) <=20 ) {
            [self _animationSlideToX:0 duration:0.1f];
        }else if (dx<0){
            if ([panGestureReconginzer translationInView:self.view].x <0) {
                [self SlideRightSideShow];
            }else{
                [self SlideDobuleSideHidden];
            }
            
        }else if (dx>0){
            if([panGestureReconginzer translationInView:self.view].x > 0){
                [self SlideLeftSideShow];
            }else{
                [self SlideDobuleSideHidden];
            }
        }
        _mainViewPreTransformTx =[self _mainView].transform.tx;
        
    }else{
        [self _transformToX:translation];
        if ([self _mainView].frame.origin.x >0 && [self _rightSideView]) {
            [self _rightSideView].hidden = YES;
            [self _leftSideView]?[self _leftSideView].hidden = NO:false;
        }
        if ([self _mainView].frame.origin.x <0 && [self _leftSideView]) {
            [self _leftSideView].hidden = YES;
            [self _rightSideView]?[self _rightSideView].hidden = NO:false;
        }
    }
    
    
}

@end
