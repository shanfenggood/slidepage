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
    
    UIView* _redFlag;
    
    int _selectPage;
    int _scorllViewTx;
}

@end

@implementation TabScrollViewController

-(void)switchPageWithIndex:(int)index
{
    [UIView animateWithDuration:0.3 animations:^{
            double newTranslation = (0 - index * self.view.frame.size.width);
            [self _transformToX:newTranslation];
    } completion:^(BOOL finished) {
            _scorllViewTx =_scrollView.transform.tx;
    }];
    
    int count = 0;
    for (UIView* view in [_tabView subviews])
    {
        if ([view isKindOfClass:[UILabel class]]) {
            if (count == index) {
                
                [UIView animateWithDuration:0.3 animations:^{
                    _redFlag.frame = CGRectMake(view.frame.origin.x,
                                                _tabView.frame.size.height-3,
                                                view.frame.size.width, 3);
                } completion:nil];

                [_tabView scrollRectToVisible:view.frame animated:YES];
                return;
            }
            count++;
        }
    }

    
}


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

- (void)_swithPage:(UITapGestureRecognizer *)panGestureReconginzer
{
    int count = 0;
    for (UIView* view in [_tabView subviews])
    {
        if ([view isKindOfClass:[UILabel class]]) {
            if(panGestureReconginzer.view == view)
            {
            return [self switchPageWithIndex:count];
            }
            count ++;
        }
    }
}

-(void) _initTabView
{
    _selectPage = 0; //select first
    _tabView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    [self.view addSubview:_tabView];
    
    _tabView.backgroundColor = [UIColor lightGrayColor];

    int count = 0;
    int labelX = 10;
    for(TabInfo* tabInfo in _tabInfos)
    {
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, 0, 40, 20)];
        CGSize size = [tabInfo.title sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        label.frame = CGRectMake(labelX, 10, size.width, size.height);
        label.text = tabInfo.title;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_swithPage:)]];
//        _tabView.cont
        [_tabView addSubview: label];
        labelX +=(size.width+10);
        count++;
    }
    _tabView.showsVerticalScrollIndicator=NO;
    _tabView.showsHorizontalScrollIndicator=NO;
    [_tabView setContentSize:CGSizeMake(labelX, _tabView.frame.size.height)];
    
    _redFlag = [[UIView alloc] initWithFrame:CGRectMake(-20, 23, 20, 2)];
    _redFlag.backgroundColor = [UIColor redColor];
    [_tabView addSubview:_redFlag];
    
    [self switchPageWithIndex:0];
}

-(void) _initScorllView
{
    _scrollView = [[UIView alloc] initWithFrame:
                   CGRectMake(0, 60,
                              self.view.frame.size.width * _tabInfos.count,self.view.frame.size.height-60)];
    _scrollView.clipsToBounds = YES;
    
    [self.view addSubview:_scrollView];
    int count = 0;
    for(TabInfo* tabInfo in _tabInfos)
    {
        tabInfo.viewController.view.frame =
        CGRectMake(self.view.frame.size.width * count, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
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
        [self switchPageWithIndex:abs(page)];
//        double newTranslation = page* self.view.frame.size.width;
//        if (translation != newTranslation ) {
//            [UIView animateWithDuration:0.3 animations:^{
//                
//                [self _transformToX:newTranslation];
//                
//            } completion:^(BOOL finished) {
//                
//                _scorllViewTx =_scrollView.transform.tx;
//                
//            }];
//
//        }
        _scorllViewTx =_scrollView.transform.tx;
    }


}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveTouch:(UITouch *)touch {

    return YES;
}


-(void) _transformToX:(int)x
{
    _scrollView.transform = CGAffineTransformMakeTranslation(x,0);
    
}
@end
