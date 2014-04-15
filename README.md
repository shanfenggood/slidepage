slidepage
=========
# Function

@property(nonatomic,assign) int maxLeftShow;

@property(nonatomic,assign) int maxRightShow;


-(void) SlideLeftSideShow;

-(void) SlideDobuleSideHidden;

-(void) SlideRightSideShow;


-(void) SetMainControl:(UIViewController*)mainControl   rightSideBackgroundController:(UIViewController*)rightControl leftSideBackgroundController:(UIViewController*)leftControl;


