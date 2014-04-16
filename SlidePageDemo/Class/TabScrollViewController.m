//
//  TabScrollViewController.m
//  SlidePageDemo
//
//  Created by shanfeng on 15/4/14.
//  Copyright (c) 2014 shanfeng. All rights reserved.
//

#import "TabScrollViewController.h"
#import "TabInfo.h"
#import "SlidePageViewController.h"
@interface TabScrollViewController ()
{
    NSArray* _tabInfos;
    UIView*  _scrollView;
    UIScrollView*  _tabView;
    
    int _scorllViewTx;
}

@end

@implementation TabScrollViewController

-(TabScrollViewController*) initWithTabs:(NSArray*) tabs
{
    if(self = [super init])
    {
        _tabInfos = [[NSArray alloc] initWithArray:tabs];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) _initTabView
{
    _tabView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 25)];
    [self.view addSubview:_tabView];
    

}
-(void) _initScorllView
{
    _scrollView = [[UIView alloc] initWithFrame:
                   CGRectMake(0, 50,
                              self.view.frame.size.width * _tabInfos.count,self.view.frame.size.height-50)];
    _scrollView.clipsToBounds = YES;
    
    [self.view addSubview:_scrollView];
    int count = 0;
    for(TabInfo* tabInfo in _tabInfos)
    {
        tabInfo.viewController.view.frame =
        CGRectMake(self.view.frame.size.width * count, 0, self.view.frame.size.width, self.view.frame.size.height);
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 40, 20)];
        label.text =[NSString stringWithFormat: @"%d",count ];
        [tabInfo.viewController.view addSubview: label];
        [_scrollView addSubview: tabInfo.viewController.view];
        count++;
    }
    
    UIPanGestureRecognizer* gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_panGesture:)];
    gesture.delegate = self;
    [_scrollView addGestureRecognizer:gesture];
    
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    
    [self _initScorllView];
    [self _initTabView];
    
    self.view.backgroundColor = [UIColor grayColor];
    //
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


- (void)_panGesture:(UIPanGestureRecognizer *)panGestureReconginzer
{
    CGFloat translation = [panGestureReconginzer translationInView:self.view].x + _scorllViewTx;
    SlidePageViewController* pC =(SlidePageViewController* )[self parentViewController];

//    NSLog(@"%f",translation);
    if (self.view.frame.origin.x != 0) {
        if(self.view.frame.origin.x >0){
            _scorllViewTx = 0;
        }else{
            _scorllViewTx = 0- (_tabInfos.count-1)*self.view.frame.size.width;
        }
        return [pC slideView:panGestureReconginzer];
    }
    if (translation>=0) {
        translation = 0;
        [pC slideView:panGestureReconginzer];
    }
    if (translation< (0- (_tabInfos.count-1)*self.view.frame.size.width )) {
        translation = (0- (_tabInfos.count-1)*self.view.frame.size.width);
        [pC slideView:panGestureReconginzer];
    }

    [self _transformToX:translation];
    if (panGestureReconginzer.state == UIGestureRecognizerStateEnded)
    {
        
        double page = translation/self.view.frame.size.width;
        if ([panGestureReconginzer translationInView:self.view].x > 0) {
            page = ceil(page);
        }else{
            page = floor(page);
        }
        double newTranslation = page* self.view.frame.size.width;
        if (translation != newTranslation ) {
            [UIView animateWithDuration:0.5 animations:^{
                
                [self _transformToX:newTranslation];
                
            } completion:^(BOOL finished) {
                
                _scorllViewTx =_scrollView.transform.tx;
                
            }];

        }
        _scorllViewTx =_scrollView.transform.tx;
    }


}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveTouch:(UITouch *)touch {

    return YES;
    [gestureRecognizer locationInView:_scrollView];
    
    NSLog(@"%f,%f,%f",[gestureRecognizer locationInView:_scrollView].x,
           [touch locationInView:_scrollView].x,
          [touch previousLocationInView:_scrollView].x);
    
    if (_scrollView.frame.origin.x >= 0) {
        return NO;
    }
    if (_scrollView.frame.origin.x <  (0- (_tabInfos.count-1)*self.view.frame.size.width)) {
        NSLog(@"%f,%f,%f",_scrollView.frame.origin.x, - (_tabInfos.count-1)*self.view.frame.size.width ,self.view.frame.size.width);
        return NO;
    }
    return YES;
    
    //    CGPoint touchLocation = [touch locationInView:self.view];
    //    return !CGRectContainsPoint(self.activeTab.frame, touchLocation);
}


-(void) _transformToX:(int)x
{
    _scrollView.transform = CGAffineTransformMakeTranslation(x,0);
    
}
@end
