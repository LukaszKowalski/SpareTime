//
//  ViewController.m
//  dupa
//
//  Created by Łukasz Kowalski on 03/02/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "CategoryViewController.h"
#import "SidebarTableViewController.h"
#import "leftViewModel.h"
#import "AFNetworking.h"


@interface CategoryViewController ()
@property (weak, nonatomic) UIView *category;
@property (strong, nonatomic) SidebarTableViewController *sidebar;
@property (weak, nonatomic) IBOutlet UIView *categoryContainer;
@property float oldX;
@property BOOL draggedToLeftView;
@property CGPoint beganTouchLocation;
@property CGPoint endedTouchLocation;
@property CGRect orginalCategoryContainerPosition;
@property UIView *statusBar;

@end

@implementation CategoryViewController

- (void)viewDidAppear:(BOOL)animated{

    [self drawCategoryButtons];
    
    self.draggedToLeftView = NO;
    float xForTableView = self.categoryContainer.frame.size.width;
    
    self.sidebar = [[SidebarTableViewController alloc] init];
    self.sidebar.delegate = self;
    self.sidebar.view.frame = CGRectMake(-xForTableView, -44, self.categoryContainer.frame.size.width, self.view.frame.size.height);
    
    self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    self.statusBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.statusBar];
    self.backgroundImage.frame = CGRectMake(-320, 0, 960, self.view.frame.size.height);

    
    [self.categoryContainer addSubview:self.sidebar.view];

    self.draggedToLeftView = NO;

   }

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    panGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:panGestureRecognizer];
    
    [self loadAndCreateIconsForCategories];
    
}

-(void)drawCategoryButtons
{
    
    self.category.tag = 666;
    
    [self drawButtonWithTag:1 withIcon:@"beer"];
    [self drawButtonWithTag:2 withIcon:@"cinema"];
    [self drawButtonWithTag:3 withIcon:@"club"];
    
    [self drawButtonWithTag:4 withIcon:@"coffee"];
    [self drawButtonWithTag:5 withIcon:@"custom"];
    [self drawButtonWithTag:6 withIcon:@"culture"];
    
    [self drawButtonWithTag:7 withIcon:@"bike"];
    
    //    [self drawClockWith:CGRectMake(130, 270, 70, 70) withIcon:@"wskazowki"];
    
    [self drawButtonWithTag:8 withIcon:@"sex"];
    
    [self drawButtonWithTag:9 withIcon:@"meeting"];
    [self drawButtonWithTag:10 withIcon:@"barsports"];
    [self drawButtonWithTag:11 withIcon:@"drink"];
    
    [self drawButtonWithTag:12 withIcon:@"food"];
    [self drawButtonWithTag:13 withIcon:@"games"];
    [self drawButtonWithTag:14 withIcon:@"smoke"];
    
}

-(void)loadAndCreateIconsForCategories
{

    NSArray *backgrounds = [[NSArray alloc] initWithObjects:@"bck_beer",@"bck_cinema",@"bck_club",@"bck_coffee",@"bck_custom",@"bck_culture",@"bck_bike",@"bck_sex",@"bck_meeting",@"bck_barsports",@"bck_drink",@"bck_food",@"bck_games",@"bck_smoke", nil];
    self.backgroundsWithTags = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [backgrounds count]; i++) {
        
       
        NSString *element = [backgrounds objectAtIndex:i];
        
        [self.backgroundsWithTags setValue:element forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
}

-(void)drawButtonWithTag:(NSUInteger)tag withIcon:(NSString *)iconName
{
    
    BOOL found = NO;

    for (UIView *myCategory in self.categoryContainer.subviews) {
        if (myCategory.tag == tag ) {
            found = YES;
            self.category = myCategory;
        }
    }
    if (found == NO) {
        return;
    }
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    self.category.clipsToBounds= YES;
    self.category.alpha = 0.90;
    self.category.layer.cornerRadius = self.category.frame.size.height/2.0f;
    
    visualEffectView.frame = CGRectMake(0, 0 , self.category.frame.size.width, self.category.frame.size.height);
    [self.category addSubview:visualEffectView];

    UIView *lightdark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.category.frame.size.width, self.category.frame.size.height)];
    lightdark.tag = 16;
    lightdark.clipsToBounds= YES;
    lightdark.layer.cornerRadius = self.category.frame.size.height/2.0f;
    
    lightdark.backgroundColor = [UIColor blackColor];
    lightdark.alpha = 0.2;
    
    [self.category addSubview:lightdark];
    [self.category bringSubviewToFront:lightdark];
    
    self.buttonIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.category.frame.size.width, self.category.frame.size.height)];
    self.buttonIcon.tag = 17;
    self.buttonIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.buttonIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", iconName]]];
    [self.category addSubview:self.buttonIcon];
    
    SpareTimeCategoryButton *button = [[SpareTimeCategoryButton alloc] initWithFrame:CGRectMake(0, 0, self.category.frame.size.width, self.category.frame.size.height)];
    button.backgroundColor = [UIColor clearColor];
    button.tag = tag;
    [button setButtonClicked:NO];
    
    [self.category addSubview:button];
    [self.category bringSubviewToFront:button];
    
    self.buttonName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.category.frame.size.width, self.category.frame.size.height)];
    self.buttonName.text = iconName;
    self.buttonName.tag = 18;
    self.buttonName.hidden = YES;
    self.buttonName.textAlignment = NSTextAlignmentCenter;
    self.buttonName.textColor = [UIColor whiteColor];
    
    [self.category addSubview:self.buttonName];
    
    [button addTarget:self action:@selector(buttonFired:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.category];
    
}

- (void)buttonFired:(id)sender{
    
    
    UIView *buttonContent = [sender superview];

    UIView *buttonLayer = [buttonContent viewWithTag:16];
    
    UIImageView *buttonImageInView = (UIImageView*)[buttonContent viewWithTag:17];
    
    UILabel *buttonNameInView = (UILabel *)[buttonContent viewWithTag:18];
    
    SpareTimeCategoryButton *button = (SpareTimeCategoryButton *)sender;
    
    if (button.buttonClicked == YES) {
    
        [self.background setImage:[UIImage imageNamed:@"background"]];
        
        buttonLayer.backgroundColor = [UIColor blackColor];
        buttonNameInView.hidden = YES;
        buttonImageInView.hidden = NO;
        button.buttonClicked = NO;
        

}
    else if (button.buttonClicked == NO){

        [UIView animateWithDuration:5.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.background setImage:[UIImage imageNamed:[self.backgroundsWithTags objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]-1]]]];
        } completion:^(BOOL finished) {
            
            [[leftViewModel sharedInstance] sideBarCategory:[(UILabel *)[buttonContent viewWithTag:18] text]];
            [[leftViewModel sharedInstance] reloadTableView];
        }];
        
        [self.backgroundImage setImage:[UIImage imageNamed:[self.backgroundsWithTags objectForKey:[NSString stringWithFormat:@"%ld",(long)[sender tag]-1]]]];
        buttonLayer.backgroundColor = [UIColor redColor];
        buttonNameInView.hidden = NO;
        buttonImageInView.hidden = YES;
        button.buttonClicked = YES;
        [self animateCircle:buttonLayer];
        
    }
}

- (void) animateCircle:(UIView *)view{
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.2;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1];
    
    [view.layer addAnimation:scaleAnimation forKey:@"scale"];}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    static CGPoint start;
    static CGPoint change;
    static CGPoint end;

    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        start = [gestureRecognizer locationInView:self.view];
        self.oldX = self.categoryContainer.frame.origin.x;
        NSLog(@"frame = %f", self.categoryContainer.frame.origin.x);

    }
    
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        change = [gestureRecognizer locationInView:self.view];
        NSLog(@"frame = %f", self.categoryContainer.frame.origin.x);

        if (self.draggedToLeftView == NO){
        self.categoryContainer.frame = CGRectMake(self.oldX + (change.x - start.x), self.categoryContainer.frame.origin.y, self.categoryContainer.frame.size.width, self.categoryContainer.frame.size.height);
            
            // background hack try
            
//            self.backgroundImage.frame = CGRectMake(self.oldX + (change.x/2.5 - start.x), self.backgroundImage.frame.origin.y, self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height);
        
        }

    }
    
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        
        end = [gestureRecognizer locationInView:self.view];
        self.endedTouchLocation = end;
        
        if (start.x < change.x && self.categoryContainer.frame.origin.x > 0.3 * self.view.frame.size.width) {
            
            [self animateToSideBar];
        }
        if (self.categoryContainer.frame.origin.x < 0.95 * self.view.frame.size.width){
            [self backToCategories];
        }
    }
    
}


- (void) animateToSideBar
{
    float xForTableView = self.categoryContainer.frame.size.width;

    if (self.draggedToLeftView == NO) {
        self.draggedToLeftView = YES;
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.categoryContainer.frame =CGRectMake(xForTableView, self.categoryContainer.frame.origin.y, self.categoryContainer.frame.size.width, self.categoryContainer.frame.size.height);
                         
//                         self.backgroundImage.frame = CGRectMake(-200, self.backgroundImage.frame.origin.y, self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height);

                         
                     }
                         completion:^(BOOL completed){
                self.draggedToLeftView = NO;
                             NSLog(@"end frame = %f", self.categoryContainer.frame.origin.x);
            
                         }
         ];
    }
}

- (void) backToCategories
{

    self.draggedToLeftView = NO;

    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.categoryContainer.frame =CGRectMake(0, self.categoryContainer.frame.origin.y, self.categoryContainer.frame.size.width, self.categoryContainer.frame.size.height);
//                          self.backgroundImage.frame = CGRectMake(-320, self.backgroundImage.frame.origin.y, self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height);
                     }
                     completion:^(BOOL completed){
                         self.draggedToLeftView = NO;

                     }
     ];
}


@end
